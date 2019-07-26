Class {
	#name : #NNetwork,
	#superclass : #Object,
	#instVars : [
		'layers',
		'errors',
		'precisions'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
NNetwork >> addLayer: aNeuronLayer [
    "Add a neural layer. The added layer is linked to the already added layers."
    layers ifNotEmpty: [ 
        aNeuronLayer previousLayer: layers last.
        layers last nextLayer: aNeuronLayer ].
    layers add: aNeuronLayer.
]

{ #category : #'as yet unclassified' }
NNetwork >> backwardPropagateError: expectedOutputs [
	"expectedOutputs corresponds to the outputs we are training the network against"
	self outputLayer backwardPropagateError: expectedOutputs
]

{ #category : #initialization }
NNetwork >> configure: nbOfInputs hidden: nbOfNeurons1 hidden: nbOfNeurons2 nbOfOutputs: nbOfOutput [
    "Configure the network with the given parameters
    The network has only one hidden layer"
    | random |
    random := Random seed: 42.
    self addLayer: (NeuronLayer new initializeNbOfNeurons: nbOfNeurons1 nbOfWeights: nbOfInputs using: random).
    self addLayer: (NeuronLayer new initializeNbOfNeurons: nbOfNeurons2 nbOfWeights: nbOfNeurons1 using: random).
    self addLayer: (NeuronLayer new initializeNbOfNeurons: nbOfOutput nbOfWeights: nbOfNeurons2 using: random).
]

{ #category : #initialization }
NNetwork >> configure: nbOfInputs hidden: nbOfNeurons nbOfOutputs: nbOfOutput [
    "Configure the network with the given parameters
    The network has only one hidden layer"
    | random |
    random := Random seed: 42.
    self addLayer: (NeuronLayer new initializeNbOfNeurons: nbOfNeurons nbOfWeights: nbOfInputs using: random).
    self addLayer: (NeuronLayer new initializeNbOfNeurons: nbOfOutput nbOfWeights: nbOfNeurons using: random).
]

{ #category : #initialization }
NNetwork >> feed: someInputValues [
    "Feed the first layer with the provided inputs"
    ^ layers first feed: someInputValues
]

{ #category : #initialization }
NNetwork >> initialize [
    super initialize.
    layers := OrderedCollection new.
    errors := OrderedCollection new.
	 precisions := OrderedCollection new.
]

{ #category : #accessing }
NNetwork >> learningRate: aLearningRate [
	"Set the learning rate for all the layers
	Note that this method should be called after configuring the network, and _not_ before"
	self assert: [ layers notEmpty ] description: 'learningRate: should be invoked after configuring the network'.
	layers do: [ :l | l learningRate: aLearningRate ] 
]

{ #category : #'as yet unclassified' }
NNetwork >> numberOfInputs [
	"Return the number of inputs the network has"
    ^ layers first neurons size
]

{ #category : #'as yet unclassified' }
NNetwork >> numberOfNeurons [
	"Return the total number of neurons the network has"
	^ (layers collect: #numberOfNeurons) sum
]

{ #category : #initialization }
NNetwork >> numberOfOutputs [
    "Return the number of output of the network"
    ^ layers last numberOfNeurons
]

{ #category : #'as yet unclassified' }
NNetwork >> outputLayer [
    "Return the output layer, which is also the last layer"
    ^ layers last
]

{ #category : #'as yet unclassified' }
NNetwork >> predict: inputs [
	"Make a prediction. This method assume that the number of outputs is the same than the number of different values the network can output"
	"The index of a collection begins at 1 in Pharo"
	| outputs |
	outputs := self feed: inputs.
	^ (outputs indexOf: (outputs max)) - 1
]

{ #category : #'as yet unclassified' }
NNetwork >> train: someInputs desiredOutputs: desiredOutputs [
    "Train the neural network with a set of inputs and some expected output"
    | realOutputs t |
    realOutputs := self feed: someInputs.
    t := (1 to: desiredOutputs size) collect: 
            [ :i | ((desiredOutputs at: i) - (realOutputs at: i)) raisedTo: 2 ].
    self backwardPropagateError: desiredOutputs.
    self updateWeights: someInputs.
]

{ #category : #'as yet unclassified' }
NNetwork >> train: train nbEpochs: nbEpoch [
    "Train the network using the train data set."
    | sumError outputs expectedOutput epochPrecision t normalizedTrain |
	normalizedTrain := Normalization new normalizeData: train.
    1 to: nbEpoch do: [ :epoch |
        sumError := 0.
          epochPrecision := 0.
        normalizedTrain do: [ :row |
            outputs := self feed: row allButLast.
            expectedOutput := Array new: self numberOfOutputs withAll: 0.
            expectedOutput at: (row last) + 1 put: 1.
            (row last = (self predict: row allButLast)) ifTrue: [ epochPrecision := epochPrecision + 1 ].
            t := (1 to: expectedOutput size) 
                    collect: [ :i | ((expectedOutput at: i) - (outputs at: i)) raisedTo: 2 ].
            sumError := sumError + t sum.
            self backwardPropagateError: expectedOutput.
            self updateWeights: row allButLast.
        ].
        errors add: sumError.
          precisions add: (epochPrecision / train size) asFloat.
    ] 
]

{ #category : #'as yet unclassified' }
NNetwork >> updateWeights: initialInputs [
    "Update the weights of the neurons using the initial inputs"
    layers first updateWeights: initialInputs
]

{ #category : #'as yet unclassified' }
NNetwork >> viewLearningCurve [
	| b ds |
	errors
		ifEmpty: [ ^ RTView new
				add: (RTLabel elementOn: 'Should first run the network');
				yourself ].
	b := RTDoubleGrapher new.

	"We define the size of the charting area"
	b extent: 500 @ 300.
	ds := RTData new.
	ds samplingIfMoreThan: 2000.
	ds noDot.
	ds connectColor: Color blue.
	ds points: (errors collectWithIndex: [ :y :i | i -> y ]).
	ds x: #key.
	ds y: #value.
	ds dotShape rectangle color: Color blue.
	b add: ds.
	ds := RTData new.
	ds samplingIfMoreThan: 2000.
	ds noDot.
	ds connectColor: Color red.
	ds points: (precisions collectWithIndex: [ :y :i | i -> y ]).
	ds x: #key.
	ds y: #value.
	ds dotShape rectangle color: Color blue.
	b addRight: ds.
	b axisX
		noDecimal;
		title: 'Epoch'.
	b axisY title: 'Error'.
	b axisYRight
		title: 'Precision';
		color: Color red.
	^ b
]

{ #category : #'as yet unclassified' }
NNetwork >> viewLearningCurveIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Learning';
		initializeView: [
			self viewLearningCurve ]
]

{ #category : #'as yet unclassified' }
NNetwork >> viewNetwork [
	| b lb |
	b := RTMondrian new.
	
	b nodes: layers forEach: [ :aLayer |
		b shape circle size: 20.
		b nodes: aLayer neurons.
		b layout verticalLine.
	].

	b shape arrowedLine; withShorterDistanceAttachPoint.
	b edges connectTo: #nextLayer.
	b layout horizontalLine gapSize: 30; center.
	
	b build.
	
	lb := RTLegendBuilder new.
	lb view: b view.
	lb addText: self numberOfNeurons asString, ' neurons'.
	lb addText: self numberOfInputs asString, ' inputs'.
	lb build.
	^ b view
]

{ #category : #'as yet unclassified' }
NNetwork >> viewNetworkIn: composite [
	<gtInspectorPresentationOrder: -5>
	composite roassal2
		title: 'Network';
		initializeView: [
			self viewNetwork ]
]
