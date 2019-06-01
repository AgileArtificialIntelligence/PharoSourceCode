Class {
	#name : #NMNetwork,
	#superclass : #Object,
	#instVars : [
		'random',
		'errors',
		'layers'
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
	lastLayer dz: dz.
	"lastLayer dw: ((dz +* layers first output transposed) collect: [ :v | v  / 4 ]).
	lastLayer db: dz sumKeepDimension / 4."
	currentLayer := lastLayer previous. 
	[ currentLayer notNil ] whileTrue: [ 
		dz := (currentLayer next w transposed +* dz) 
					multiplyPerElement: (currentLayer output collect: [ :v | v * (1 - v) ]).
		currentLayer dz: dz.
		"currentLayer dw: (dz +* x transposed / 4).
		currentLayer db: (dz sumKeepDimension / 4)."
		currentLayer := currentLayer previous.
	].


	"----"
"	| dZ2 dZ1 |
	dZ2 := layers last output - y.
	layers last dw: ((dZ2 +* layers first output transposed) collect: [ :v | v  / 4 ]).
	layers last db: dZ2 sumKeepDimension / 4.
	
	dZ1 := (layers last w transposed +* dZ2) multiplyPerElement: (layers first output collect: [ :v | v * (1 - v) ] ).
	layers first dw: (dZ1 +* x transposed / 4).
	layers first db: (dZ1 sumKeepDimension / 4).
"	
	
"	dZ2 := a2 - y.
	dW2 := (dZ2 +* a1 transposed) collect: [ :v | v  / 4 ]. 
	dB2 := dZ2 sumKeepDimension / 4. 
	
	dZ1 := (w2 transposed +* dZ2) multiplyPerElement: (a1 collect: [ :v | v * (1 - v) ] ).
	dW1 := dZ1 +* x transposed / 4. 
	dB1 := dZ1 sumKeepDimension / 4. 
"

"	layerOnTheRight := lastLayer.
	currentLayer := layers allButLast last.
	layers allButLast allButLast reverse do: [ :layerOnTheLeft |
		layerOnTheLeft := layers first.
		dz := (layerOnTheRight w transposed +* dz) multiplyPerElement: (layerOnTheLeft output collect: [ :v | v * (1 - v) ]).
		currentLayer dw: (dz +* x transposed / 4).
		currentLayer db: (dz sumKeepDimension / 4).
	
		currentLayer := layerOnTheLeft.
		layerOnTheRight := currentLayer
	]"

]

{ #category : #initialization }
NMNetwork >> computeCost: mat and: y [
"  cost = -np.sum(np.multiply(Y, np.log(A2)) +  np.multiply(1-Y, np.log(1-A2)))/m
  cost = np.squeeze(cost)
"
	| cost part1 part2 |
	part1 := y multiplyPerElement: (mat collect: #ln).
	part2 := (y collect: [ :v | 1 - v ]) multiplyPerElement: (mat collect: [ :v | (1 - v) ln ]).
	cost := (part1 + part2) sum negated / y nbColumns. 
	^ cost 
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
"   w1 := MMatrix newRows: nbOfNeurons columns: nbOfInputs.
	w1 random: random.
	b1 := MMatrix newRows: nbOfNeurons columns: 1.
	b1 random: random.
	
   w2 := MMatrix newRows: nbOfOutputs columns: nbOfNeurons.
	w2 random: random.
	b2 := MMatrix newRows: nbOfOutputs columns: 1.
	b2 random: random."
	self addLayer: (NMLayer new nbInputs: nbOfNeurons1 nbOutputs: nbOfInputs random: random).
	self addLayer: (NMLayer new nbInputs: nbOfNeurons2 nbOutputs: nbOfNeurons1 random: random).

	self addLayer: (NMLayer new nbInputs: nbOfOutputs nbOutputs: nbOfNeurons2 random: random).

	"FOR DEBUGGING:"
"	layers first w fromContents: #(0.89384457 -0.52278163 -0.42612507 -0.06425599 1.21949323 -0.75523643).
	layers first b fromContents: #(0 0 0).
	layers second w fromContents: #( 0.76098351 -0.24948336  0.39131117 -1.30928897  0.48329017 -0.10899267).
	layers second b fromContents: #(0 0)."
]

{ #category : #initialization }
NMNetwork >> configure: nbOfInputs hidden: nbOfNeurons nbOfOutputs: nbOfOutputs [
    "Configure the network with the given parameters
    The network has only one hidden layer"
 
	random := Random seed: 42.
	self addLayer: (NMLayer new nbInputs: nbOfNeurons nbOutputs: nbOfInputs random: random).
	self addLayer: (NMLayer new nbInputs: nbOfOutputs nbOutputs: nbOfNeurons random: random).
	
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
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

{ #category : #initialization }
NMNetwork >> feed: inputs [
	| mat |
	"mat := MMatrix newFromVector: inputs."
	mat := inputs.

	layers do: [ :l |
		mat := l feed: mat.
	].
	^ mat

	"a1 := (w1 +* mat + b1) collect: [ :v | 1 / (1 + v negated exp) ].
	
	a2 := (w2 +* a1 + b2) collect: [ :v | 1 / (1 + v negated exp) ].
	^ a2"
	
"a1 := z1 collect: [ :v | v exp - v negated exp / (v exp + v negated exp) ]."
]

{ #category : #initialization }
NMNetwork >> initialize [
	super initialize.
	layers := OrderedCollection new.
	random := Random seed: 42.
]

{ #category : #'as yet unclassified' }
NMNetwork >> modelX: x y: y nbOfEpochs: nbEpochs [

	| cost output |
	errors := OrderedCollection new.
	nbEpochs timesRepeat: [ 
		output := self feed: x.
		cost := self computeCost: output and: y.
		self backwardX: x  y: y.
		self update: x.
		errors add: cost.
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
	
	labels := data collect: #last.
	numberOfOutputs := labels asSet size.
	labels := labels collect: [ :row |
		| expectedOutput |
		expectedOutput := (1 to: numberOfOutputs) collect: [ :notUsed | 0 ].
   		expectedOutput at: row + 1 put: 1.
		expectedOutput
		"{ 0 . 0 . 0 } at: (i + 1) put: 1"
	].
	"expectedOutput := (1 to: self numberOfOutputs) collect: [ :notUsed | 0 ].
   expectedOutput at: (row last) + 1 put: 1."
	y := (MMatrix newFromArrays: labels) transposed.
	^ self modelX: x y: y nbOfEpochs: nbEpochs

]

{ #category : #'as yet unclassified' }
NMNetwork >> update: input [
	layers first update: input
"	lr := 0.3.
	w1 := w1 - (dW1 * lr).
	b1 := b1 - (dB1 * lr).
	w2 := w2 - (dW2 * lr).
	b2 := b2 - (dB2 * lr)."
]

{ #category : #'as yet unclassified' }
NMNetwork >> viewLearningCurve [
	| b ds |
	errors
		ifEmpty: [ ^ RTView new
				add: (RTLabel elementOn: 'Should first run the network');
				yourself ].

	b := RTGrapher new.

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
	
"	ds := RTData new.
	ds samplingIfMoreThan: 2000.
	ds noDot.
	ds connectColor: Color red.
	ds points: (precisions collectWithIndex: [ :y :i | i -> y ]).
	ds x: #key.
	ds y: #value.
	ds dotShape rectangle color: Color blue.
	b addRight: ds."
	
	b axisX
		noDecimal;
		title: 'Epoch'.
	b axisY title: 'Error'.
	"b axisYRight
		title: 'Precision';
		color: Color red."
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
