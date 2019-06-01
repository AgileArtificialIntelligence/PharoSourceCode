Class {
	#name : #NMNetwork,
	#superclass : #Object,
	#instVars : [
		'random',
		'errors',
		'layers',
		'precisions'
	],
	#category : #'NeuralNetwork-Matrix'
}

{ #category : #initialization }
NMNetwork >> addLayer: aLayer [
	layers ifNotEmpty: [
		layers last next: aLayer. 
		aLayer previous: layers last ].
	layers add: aLayer
]

{ #category : #'as yet unclassified' }
NMNetwork >> backwardX: x y: y [
	| lastLayer dz currentLayer |
	lastLayer := layers last.
	dz := lastLayer output - y.	
	lastLayer delta: dz.
	currentLayer := lastLayer previous. 
	[ currentLayer notNil ] whileTrue: [ 
		dz := (currentLayer next w transposed +* dz) 
					multiplyPerElement: (currentLayer output collect: [ :v | v * (1 - v) ]).
		currentLayer delta: dz.
		currentLayer := currentLayer previous.
	].

]

{ #category : #initialization }
NMNetwork >> computeCost: mat and: y [
"  cost = -np.sum(np.multiply(Y, np.log(A2)) +  np.multiply(1-Y, np.log(1-A2)))/m
  cost = np.squeeze(cost)
"

	^ ((mat - y) collect: [ :v | v * v ]) sum

"	| cost part1 part2 |
	part1 := y multiplyPerElement: (mat collect: #ln).
	part2 := (y collect: [ :v | 1 - v ]) multiplyPerElement: (mat collect: [ :v | (1 - v) ln ]).
	cost := (part1 + part2) sum negated / y nbColumns. 
	^ cost "
]

{ #category : #initialization }
NMNetwork >> configure: nbOfInputs hidden: nbOfNeurons1 hidden: nbOfNeurons2 hidden: nbOfNeurons3 nbOfOutputs: nbOfOutputs [
    "Configure the network with the given parameters
    The network has only one hidden layer"
 
	random := Random seed: 42.
	self addLayer: (NMLayer new nbInputs: nbOfNeurons1 nbOutputs: nbOfInputs random: random).
	self addLayer: (NMLayer new nbInputs: nbOfNeurons2 nbOutputs: nbOfNeurons1 random: random).
	self addLayer: (NMLayer new nbInputs: nbOfNeurons3 nbOutputs: nbOfNeurons2 random: random).
	self addLayer: (NMLayer new nbInputs: nbOfOutputs nbOutputs: nbOfNeurons3 random: random).

]

{ #category : #initialization }
NMNetwork >> configure: nbOfInputs hidden: nbOfNeurons1 hidden: nbOfNeurons2 nbOfOutputs: nbOfOutputs [
    "Configure the network with the given parameters
    The network has only one hidden layer"
 
	random := Random seed: 42.
	self addLayer: (NMLayer new nbInputs: nbOfNeurons1 nbOutputs: nbOfInputs random: random).
	self addLayer: (NMLayer new nbInputs: nbOfNeurons2 nbOutputs: nbOfNeurons1 random: random).
	self addLayer: (NMLayer new nbInputs: nbOfOutputs nbOutputs: nbOfNeurons2 random: random).

]

{ #category : #initialization }
NMNetwork >> configure: nbOfInputs hidden: nbOfNeurons nbOfOutputs: nbOfOutputs [
    "Configure the network with the given parameters
    The network has only one hidden layer"
 
	random := Random seed: 42.
	self addLayer: (NMLayer new nbInputs: nbOfNeurons nbOutputs: nbOfInputs random: random).
	self addLayer: (NMLayer new nbInputs: nbOfOutputs nbOutputs: nbOfNeurons random: random).
	
]

{ #category : #examples }
NMNetwork >> example01 [
	<script: 'self new example01 inspect'>
	
	| n x y |
	x := MMatrix newRows: 2 columns: 4.
	x fromContents: #(0 1 0 1 0 0 1 1).
	
	y := MMatrix newRows: 1 columns: 4.
	y fromContents: #(0 0 1 1).
	
	n := NMNetwork new configure: 2 hidden: 2 nbOfOutputs: 1.
	n modelX: x y: y nbOfEpochs: 1000.
	^ n
]

{ #category : #examples }
NMNetwork >> example02 [
	<script: 'self new example02 inspect'>
	
	| n x y |
	x := MMatrix newRows: 2 columns: 4.
	x fromContents: #(0 0 1 1 0 1 0 1).
	
	y := MMatrix newRows: 2 columns: 4.
	y fromContents: #(1 1 1 0 0 0 0 1).
	
	n := NMNetwork new configure: 2 hidden: 3 nbOfOutputs: 2.
	n modelX: x y: y nbOfEpochs: 1000.
	^ n
]

{ #category : #examples }
NMNetwork >> example03 [
	<script: 'self new example03 inspect'>
	
	"
	self new example03
	"
	| n x y |
	x := MMatrix newRows: 2 columns: 4.
	x fromContents: #(0 0 1 1 0 1 0 1).
	
	y := MMatrix newRows: 2 columns: 4.
	y fromContents: #(1 1 1 0 0 0 0 1).
	
	n := NMNetwork new configure: 2 hidden: 3 hidden: 3 hidden: 4 nbOfOutputs: 2.
	n modelX: x y: y nbOfEpochs: 10000.
	^ n
]

{ #category : #examples }
NMNetwork >> exampleSeed [
	<script: 'self new exampleSeed'>
	| n |
	n := NNetwork  new.
	n configure: 7 hidden: 3 nbOfOutputs: 3.
	n train: NNDataset new normalizedSeedsDatasets nbEpochs: 2000.
	^ n
]

{ #category : #initialization }
NMNetwork >> feed: inputs [
	| mat |
	mat := inputs.
	layers do: [ :l |
		mat := l feed: mat.
	].
	^ mat

]

{ #category : #initialization }
NMNetwork >> initialize [
	super initialize.
	layers := OrderedCollection new.
	random := Random seed: 42.
]

{ #category : #accessing }
NMNetwork >> lr: aLearningRateAsFloat [
	layers do: [ :l | l lr: aLearningRateAsFloat ]
]

{ #category : #'as yet unclassified' }
NMNetwork >> modelX: x y: y nbOfEpochs: nbEpochs [
	| cost output |
	errors := OrderedCollection new.
	precisions := OrderedCollection new.
	nbEpochs timesRepeat: [ 
		output := self feed: x.
		cost := self computeCost: output and: y.
		self backwardX: x  y: y.
		self update: x.
		errors add: cost.
		precisions add: ((output multiplyPerElement: y) / 3) sum / y nbRows.
	].
	^ cost
]

{ #category : #'as yet unclassified' }
NMNetwork >> predict: inputs [
	"Make a prediction. This method assume that the number of outputs is the same than the number of different values the network can output"
	"The index of a collection begins at 1 in Pharo"
	| outputs |
	outputs := self feed: inputs.
	^ (outputs asArray indexOf: (outputs max)) - 1
]

{ #category : #'as yet unclassified' }
NMNetwork >> train: data nbEpochs: nbEpochs [
	| x y labels numberOfOutputs |
	x := (MMatrix newFromArrays: (data collect: #allButLast)) transposed.
	layers do: [ :l | l numberOfExamples: data size ].
	labels := data collect: #last.
	numberOfOutputs := labels asSet size.
	labels := labels collect: [ :row |
		| expectedOutput |
		expectedOutput := Array new: numberOfOutputs withAll: 0.
   		expectedOutput at: row + 1 put: 1.
		expectedOutput
	].
	y := (MMatrix newFromArrays: labels) transposed.
	^ self modelX: x y: y nbOfEpochs: nbEpochs

]

{ #category : #'as yet unclassified' }
NMNetwork >> update: input [
	layers first update: input

]

{ #category : #'as yet unclassified' }
NMNetwork >> viewLearningCurve [
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
NMNetwork >> viewLearningCurveIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal2
		title: 'Learning';
		initializeView: [
			self viewLearningCurve ]
]
