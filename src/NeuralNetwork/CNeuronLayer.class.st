"
This class is a convolution layer.

It will contain features and neurons for doing a convolution.

@yvanGuemkam. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	features:		<Object>
	neurons:		<Object>
	outputVolumeSizes:		<Object>
	receptiveFields:		<Object>
	stride:		<Object>
	zeroPaddingSize:		<Object>


    Implementation Points
"
Class {
	#name : #CNeuronLayer,
	#superclass : #Object,
	#instVars : [
		'features',
		'neurons',
		'receptiveFields',
		'paddedInput',
		'stride',
		'zeroPaddingSize',
		'previousLayer',
		'nextLayer',
		'learningRate'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #accessing }
CNeuronLayer >> adjustBias [
	"To adjust bias of all features in this layer."

	| width height res |
	width := neurons size.
	height := neurons anyOne size.
	features := features collectWithIndex: [ :feature :i |
		res := 0.0.
		1 to: width do: [ :m |
			1 to: height do: [ :n |
				res := (((neurons at: m) at: n) at: i) delta + res ]].
		feature bias: (feature bias + (learningRate * res)).
		feature ]
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> adjustWeightsWithInputs: inputs [
	"To adjust weights of all features in this layer."

	| width height cuboid res |
	width := neurons size.
	height := neurons anyOne size.
	features := features collectWithIndex: [ :feature :i |
		cuboid := feature characteristics collectWithIndex: [ :row :k |
			row collectWithIndex: [ :col :l |
				col collectWithIndex: [ :weight :j |
					res := 0.0.
					1 to: width do: [ :m |
						1 to: height do: [ :n |
							res := (((inputs at: (stride * (m - 1) + k)) at: (stride * (n - 1) + l)) at: j) * 
										((((neurons at: m) at: n) at: i) delta) ]].
					weight + (learningRate * res) ]]].
		feature characteristics: cuboid.
		feature ]
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> backwardAssignError [
	"When the next layer is a FlattenLayer."

	| nextLayerDeltas |
	nextLayerDeltas := self nextLayer deltas.
	neurons doWithIndex: [ :row :i |
		row doWithIndex: [ :col :j |
			col doWithIndex: [ :neuron :k | neuron adjustDeltaWith: (((nextLayerDeltas at: i) at: j) at: k) ] ] ]
]

{ #category : #initialization }
CNeuronLayer >> backwardPropagateError [
	"To adjust weights of features in many cases."
	
	self computeDelta.

	self previousLayer notNil ifTrue: [ self previousLayer backwardPropagateError ].
]

{ #category : #initialization }
CNeuronLayer >> computeDelta [
	"To compute derivatives with respect to the input. The next layer is not a flatten layer."
	
	| nextLayerDeltas nnFeaturesWidth nnFeaturesHeight nnStride featWidth featHeight result |
	nextLayerDeltas := self nextLayer deltas.
	nnFeaturesWidth := features anyOne characteristics size.
	nnFeaturesHeight := features anyOne characteristics anyOne size.
	nnStride := self nextLayer nextLayer stride.
	featWidth := features anyOne characteristics size.
	featHeight := features anyOne characteristics anyOne size.
	
	neurons doWithIndex: [ :row :n |
							row doWithIndex: [ :col :p |
								col doWithIndex: [ :neuron :m |
									result := 0.0.
									nextLayerDeltas doWithIndex: [ :nextLayerRow :j |
										1 to: nnFeaturesWidth do: [ :b |
											nextLayerRow doWithIndex: [ :nextLayerColumn :k |
												1 to: nnFeaturesHeight do: [ :c |
													nextLayerColumn doWithIndex: [ :delta :i |
														| cond1 cond2 cond3 |
														cond1 := (nnStride * (j - 1) + b = n) and: (nnStride * (k - 1) + c = p).
														cond2 := ((n - featWidth) / stride + 1 <= j) and: ((n - 1) / stride + 1 >= j).
														cond3 := ((p - featHeight) / stride + 1 <= k) and: ((p - 1) / stride + 1 >= k).
														(cond1 and: (cond2 and: cond3)) ifTrue: [ 
															result := result +
																(delta * ((((self nextLayer features) at: i) characteristics at: b) at: c) at: m). ]
														]]]]].
									neuron adjustDeltaWith: result ] ] ]
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> configurePaddingSizeForInputSize: inputSize [
	"To calculate the length of zero padding surface."

	| featureSize outputSize |
	featureSize := features anyOne characteristics size.
	outputSize := neurons size.
	receptiveFields := (1 to: outputSize) collect: [ :notUsed | Array new: outputSize ].
	zeroPaddingSize := (((outputSize - 1) * stride) - inputSize + (featureSize)) / 2
]

{ #category : #accessing }
CNeuronLayer >> createPaddedCuboid: inputCuboid [
	"To do zero padding."

	| inputDepth zeroArray nbOfColumns zeroRow |
	inputDepth := inputCuboid anyOne anyOne size.
	zeroArray := (1 to: inputDepth) collect: [ :e | 0 ].
	paddedInput := inputCuboid collect: [ :elmt |
		| t |
		t := elmt.
		zeroPaddingSize timesRepeat: [ t := t copyWithFirst: zeroArray ];
			timesRepeat: [ t := t copyWith: zeroArray ].
		t ].
	nbOfColumns := paddedInput anyOne size.
	zeroRow := (1 to: nbOfColumns) collect: [ :e | zeroArray ].
	zeroPaddingSize timesRepeat: [ 
		paddedInput := paddedInput copyWith: zeroRow.
		paddedInput := paddedInput copyWithFirst: zeroRow ].
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> createReceptiveFields [
	"To create the receptive fields."

	| paddedSize featureSize receptiveField cuboid |
	featureSize := features anyOne characteristics size.
	paddedSize := paddedInput size.
	
	1 to: (paddedSize - featureSize + 1) by: stride do: [ :firstRowIndex |
		1 to: (paddedSize - featureSize + 1) by: stride do: [ :firstColumnIndex |
			| rowIndex columnIndex |
			rowIndex := 1 + ((firstRowIndex - 1) / stride).
			columnIndex := 1 + ((firstColumnIndex - 1) / stride).
			cuboid := (firstRowIndex to: (featureSize + firstRowIndex - 1)) collect: [ :iRow |
						(firstColumnIndex to: (featureSize + firstColumnIndex - 1)) collect: [ :iCol |
						(paddedInput at: iRow) at: iCol ] ].
			receptiveField := ReceptiveField new entries: cuboid; row: rowIndex; column: columnIndex; yourself.
			(receptiveFields at: rowIndex) at: columnIndex put: receptiveField ] ].
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> deltas [
	"To collect deltas of all neurons of the layer."

	^ neurons collect: [ :row | row collect: [ :col | col collect: #delta ] ].
]

{ #category : #accessing }
CNeuronLayer >> features [
	"To get features of the layer"

	^ features.
]

{ #category : #accessing }
CNeuronLayer >> features: anArrayOfFeatures [
	"To set features of the layer"

	features := anArrayOfFeatures.
]

{ #category : #initialization }
CNeuronLayer >> feed: anInputVolume [
	"To feed this layer with some input volume value."

	| inputSize outputVolume |
	inputSize := anInputVolume size.
	self configurePaddingSizeForInputSize: inputSize.
	self createPaddedCuboid: anInputVolume.
	self createReceptiveFields;
			setWeightsIntoNeurons;
			feedWithReceptiveField.
	outputVolume := neurons collect: [ :row | row collect: [ :col | col collect: [ :neuron | neuron output ]]].
	^ nextLayer ifNotNil: [ nextLayer feed: outputVolume ]
]

{ #category : #accessing }
CNeuronLayer >> feedWithReceptiveField [
	"To give proper input in each neuron in the layer."

	features doWithIndex: [ :feature :index |
		neurons doWithIndex: [ :aRowOfNeurons :rowIndex |
			aRowOfNeurons doWithIndex: [ :anArrayOfNeurons :columnIndex |
				(anArrayOfNeurons at: index) feedConvolutional: (((receptiveFields at: rowIndex) at: columnIndex) entries) withBias: (feature bias) ]]].
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> initialize [
	"To initialize a convolution layer with specific stride."

	super initialize.
	stride := 1.
	learningRate := 0.1.
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> initializeForNbOfFeatures: nbOfFeatures withWidth: width height: height depth: depth andOutputSize: outputSize [
	"To configure the layer with an 3D array of features."

	features := (1 to: nbOfFeatures) collect: [ :index |
		Feature new initializeWidth: width height: height depth: depth; depth: index ].
	self neuronsWidth: outputSize height: outputSize depth: nbOfFeatures.
]

{ #category : #accessing }
CNeuronLayer >> learningRate [
	"To get learningRate attribute."

	^ learningRate
]

{ #category : #accessing }
CNeuronLayer >> learningRate: aLearningRate [
	"To set learningRate attribute."

	learningRate := aLearningRate
]

{ #category : #accessing }
CNeuronLayer >> neurons [
	"To get the neurons of the layer"

	^ neurons.
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> neuronsWidth: width height: height depth: depth [
	"To configure the layer with an 3D array of neurons."

	| arr |
	arr := (1 to: width) collect: [ :notUsed1 | (1 to: height) collect: [ :notUsed2 | Array new: depth ]].
	neurons := arr collect: [ :i | i collect: [ :j | j collect: [ :k | CNeuron new bias: 0; tanh; yourself ]]]. 
]

{ #category : #accessing }
CNeuronLayer >> nextLayer [
	"To get the nextLayer attribute."

	^ nextLayer.
]

{ #category : #accessing }
CNeuronLayer >> nextLayer: aLayer [
	"To set the nextLayer attribute."

	nextLayer := aLayer
]

{ #category : #accessing }
CNeuronLayer >> numberOfFeatures [
	"To get number of features the layer have."

	^ features size.
]

{ #category : #accessing }
CNeuronLayer >> outputVolumeSize [
	"To get outputVolumeSize of the layer"

	^ receptiveFields size.
]

{ #category : #'as yet unclassified' }
CNeuronLayer >> outputs [
	"To return output volume."

	^ neurons collect: [ :row |
		row collect: [ :col | col collect: #output ] ]
]

{ #category : #accessing }
CNeuronLayer >> previousLayer [
	"To get the previousLayer attribute."

	^ previousLayer
]

{ #category : #accessing }
CNeuronLayer >> previousLayer: aLayer [
	"To set the previousLayer attribute."

	previousLayer := aLayer
]

{ #category : #accessing }
CNeuronLayer >> setWeightsIntoNeurons [
	"To dispatch shared weights to all neurons that will do a convolution on a filter."

	features doWithIndex: [ :feature :index |
		neurons do: [ :aRowOfNeurons |
			aRowOfNeurons do: [ :anArrayOfNeurons |
				(anArrayOfNeurons at: index) weights: (feature characteristics) ] ] ].
]

{ #category : #accessing }
CNeuronLayer >> stride [
	"To get stride of the layer"

	^ stride.
]

{ #category : #accessing }
CNeuronLayer >> stride: anInteger [
	"To set stride of the layer"

	stride := anInteger.
]

{ #category : #initialization }
CNeuronLayer >> updateWeights [
	"To update weights of a neuron based the set of previous layer outputs as input. Then, we are in the second hidden layer or in the output layer."
	
	self adjustWeightsWithInputs: paddedInput.
	self adjustBias.
	
	self nextLayer ifNotNil: [ self nextLayer updateWeights ]
]

{ #category : #accessing }
CNeuronLayer >> zeroPaddingSize [
	"To get zeroPaddingSize of the layer"

	^ zeroPaddingSize.
]
