"
This class implement a pooling layer.

This class allow to do a pooling operation in Convolutional Networks.

@yvanGuemkam

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	mode:		<Object>
	receptiveFields:		<Object>
	stride:		<Object>
	units:		<Object>


    Implementation Points
"
Class {
	#name : #PoolingLayer,
	#superclass : #Object,
	#instVars : [
		'mode',
		'units',
		'receptiveFields',
		'stride',
		'receptiveFieldSize',
		'previousLayer',
		'nextLayer',
		'deltaCuboid'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
PoolingLayer >> backwardPropagateError [
	"To adjust weights of features in many cases."
	
	self nextLayer isFullyConnected ifTrue: [ self computeDeltaWithoutNextLayer ]
												ifFalse: [ self computeDeltaWithNextLayer ].

	self previousLayer notNil ifTrue: [ self previousLayer backwardPropagateError ].
]

{ #category : #initialization }
PoolingLayer >> computeDeltaWithNextLayer [
	"The next layer is not a fully connected layer."
	
	| nextLayerDeltas nextLayerFeaturesWidth nextLayerFeaturesHeight width height depth result nStride pStride pFeatWidth pFeatHeight  |
	nextLayerDeltas := self nextLayer deltas.
	nextLayerFeaturesWidth := self nextLayer features anyOne characteristics size.
	nextLayerFeaturesHeight := self nextLayer features anyOne characteristics anyOne size.
	width := units size.
	height := units anyOne size.
	depth := units anyOne anyOne outputArray size.
	nStride := self nextLayer stride.
	pStride := self previousLayer stride.
	pFeatWidth := self previousLayer features anyOne characteristics size.
	pFeatHeight := self previousLayer features anyOne characteristics anyOne size.
	
	deltaCuboid := (1 to: width) collect: [ :n |
							(1 to: height) collect: [ :p |
								(1 to: depth) collect: [ :m |
									result := 0.0.
									nextLayerDeltas doWithIndex: [ :nextLayerRow :j |
										1 to: nextLayerFeaturesWidth do: [ :b |
											nextLayerRow doWithIndex: [ :nextLayerColumn :k |
												1 to: nextLayerFeaturesHeight do: [ :c |
													nextLayerColumn doWithIndex: [ :delta :i |
														| cond1 cond2 cond3 |
														cond1 := (nStride * (j - 1) + b = n) and: (nStride * (k - 1) + c = p).
														cond2 := ((n - pFeatWidth) / pStride + 1 <= j) and: ((n - 1) / pStride + 1 >= j).
														cond3 := ((p - pFeatHeight) / pStride + 1 <= k) and: ((p - 1) / pStride + 1 >= k).
														(cond1 and: (cond2 and: cond3)) ifTrue: [ 
															result := result +
																(delta * ((((self nextLayer features) at: i) characteristics at: b) at: c) at: m). ]
														]]]]].
									result ] ] ]
]

{ #category : #initialization }
PoolingLayer >> computeDeltaWithoutNextLayer [
	"The next layer is a fully connected layer."
	
	| nextLayerDeltas width height depth |
	width := units size.
	height := units anyOne size.
	depth := units anyOne anyOne outputArray size.
	nextLayerDeltas := self nextLayer deltas.
	deltaCuboid := (1 to: width) collect: [ :i | (1 to: height) collect: [ :j |
							(1 to: depth) collect: [ :k | nextLayerDeltas at: k ] ] ].
]

{ #category : #initialization }
PoolingLayer >> configureOutputForInputSize: inputSize [
	"To compute the output volume size and make some configurations."

	| outputSize |
	outputSize := (inputSize - receptiveFieldSize) / stride + 1.
	units := (1 to: outputSize)
		collect:
			[ :notUsed1 | (1 to: outputSize) collect: [ :notUsed2 | self mode = #MAX ifTrue: [MaxPoolingUnit new ] ]].
	receptiveFields := (1 to: outputSize)
		collect: [ :notUsed | Array new: outputSize ]
]

{ #category : #initialization }
PoolingLayer >> createReceptiveFields: inputs [
	"To create receptive fields for doing the pooling."

	| inputSize cuboid receptiveField |
	inputSize := inputs size.
	
	1 to: (inputSize - receptiveFieldSize + 1) by: stride do: [ :firstRowIndex |
		1 to: (inputSize - receptiveFieldSize + 1) by: stride do: [ :firstColumnIndex |
			| rowIndex columnIndex |
			rowIndex := 1 + ((firstRowIndex - 1) / stride).
			columnIndex := 1 + ((firstColumnIndex - 1) / stride).
			cuboid := (firstRowIndex to: (receptiveFieldSize + firstRowIndex - 1)) collect: [ :iRow |
						(firstColumnIndex to: (receptiveFieldSize + firstColumnIndex - 1)) collect: [ :iCol |
						(inputs at: iRow) at: iCol ] ].
			receptiveField := ReceptiveField new entries: cuboid; row: rowIndex; column: columnIndex; yourself.
			(receptiveFields at: rowIndex) at: columnIndex put: receptiveField ] ].
]

{ #category : #'as yet unclassified' }
PoolingLayer >> deltas [
	"To get delta from next convlolutional layer."

	^ deltaCuboid
]

{ #category : #accessing }
PoolingLayer >> features [
	"To get features of the next convolutional layer."

	^ self nextLayer features
]

{ #category : #initialization }
PoolingLayer >> feed: inputVolume [
	"To execute the pooling on some inputs."

	| inputSize outputVolume |
	inputSize := inputVolume size.
	self configureOutputForInputSize: inputSize.
	self createReceptiveFields: inputVolume.
	self feedWithReceptiveField.
	outputVolume := units collect: [ :row | row collect: [ :unit | unit outputArray ]].
	^ (outputVolume anyOne size = 1) ifTrue: [ nextLayer ifNotNil: [ nextLayer feed: (outputVolume flattened) ] ] 
											ifFalse: [ nextLayer ifNotNil: [ nextLayer feed: outputVolume ] ]
]

{ #category : #initialization }
PoolingLayer >> feedWithReceptiveField [
	"To evaluate the result of the pooling layer on an input volume."

	units doWithIndex: [ :columnUnits :rowIndex |
		columnUnits doWithIndex: [ :unit :columnIndex | unit feed: (((receptiveFields at: rowIndex) at: columnIndex) entries)]]
]

{ #category : #initialization }
PoolingLayer >> initialize [
	"To custom initialization of PoolingLayer to be a max pooling by default."

	super initialize
]

{ #category : #initialization }
PoolingLayer >> initializeForReceptiveFieldSize: anInteger withStride: aStride [
	"To configure receptive fields size and stride."

	receptiveFieldSize := anInteger.
	stride := aStride.
]

{ #category : #testing }
PoolingLayer >> isFullyConnected [
	"To know if the layer is a fully connected layer."

	^ false
]

{ #category : #accessing }
PoolingLayer >> mode [
	"To get mode attribute of the layer."

	^ mode
]

{ #category : #accessing }
PoolingLayer >> mode: aSymbol [
	"To set mode attribute of the layer. This mode should be MAX or AVG."

	mode := aSymbol
]

{ #category : #accessing }
PoolingLayer >> nextLayer [
	"To get the nextLayer attribute."

	^ nextLayer
]

{ #category : #accessing }
PoolingLayer >> nextLayer: aLayer [
	"To set the nextLayer attribute."

	nextLayer := aLayer
]

{ #category : #'as yet unclassified' }
PoolingLayer >> outputs [
	"To get output of the layer."

	^ units collect: [ :row | row collect: #outputArray ]
]

{ #category : #accessing }
PoolingLayer >> previousLayer [
	"To get the previousLayer attribute."

	^ previousLayer
]

{ #category : #accessing }
PoolingLayer >> previousLayer: aLayer [
	"To set the previousLayer attribute."

	previousLayer := aLayer
]

{ #category : #accessing }
PoolingLayer >> stride [
	"To get stride attribute of the layer."

	^ stride
]

{ #category : #accessing }
PoolingLayer >> stride: anInteger [
	"To set stride attribute of the layer."

	stride := anInteger
]

{ #category : #accessing }
PoolingLayer >> units [
	"To get units attribute of the layer."

	^ units
]

{ #category : #initialization }
PoolingLayer >> updateWeights [
	"To skip because it is a pooling layer."
	
	self nextLayer notNil ifTrue: [ self nextLayer updateWeights ].
]
