Class {
	#name : #NNetwork,
	#superclass : #Object,
	#instVars : [
		'layers',
		'errors',
		'precisions'
	],
	#category : #NeuralNetwork
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
	"Set the learning rate for all the layers"
	layers do: [ :l | l learningRate: aLearningRate ] 
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
    self updateWeight: someInputs.
]

{ #category : #'as yet unclassified' }
NNetwork >> train: train nbEpoch: nbEpoch [
    "Train the network using the train data set."
    | sumError outputs expectedOutput epochPrecision t |
    1 to: nbEpoch do: [ :epoch |
        sumError := 0.
          epochPrecision := 0.
        train do: [ :row |
            outputs := self feed: row allButLast.
            expectedOutput := (1 to: self numberOfOutputs) collect: [ :notUsed | 0 ].
            expectedOutput at: (row last) + 1 put: 1.
            (row last = (self predict: row allButLast)) ifTrue: [ epochPrecision := epochPrecision + 1 ].
            t := (1 to: expectedOutput size) 
                    collect: [ :i | ((expectedOutput at: i) - (outputs at: i)) raisedTo: 2 ].
            sumError := sumError + t sum.
            self backwardPropagateError: expectedOutput.
            self updateWeight: row allButLast.
        ].
        errors add: sumError.
          precisions add: (epochPrecision / train size) asFloat.
    ] 
]

{ #category : #'as yet unclassified' }
NNetwork >> updateWeight: initialInputs [
    "Update the weights of the neurons using the initial inputs"
    layers first updateWeight: initialInputs
]

{ #category : #'as yet unclassified' }
NNetwork >> viewErrorCurve [
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
