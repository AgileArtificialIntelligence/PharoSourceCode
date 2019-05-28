Class {
	#name : #NMNetwork,
	#superclass : #Object,
	#instVars : [
		'w1',
		'b1',
		'w2',
		'b2',
		'random',
		'a1',
		'a2',
		'dW2',
		'dB2',
		'dW1',
		'dB1',
		'errors'
	],
	#category : #'NeuralNetwork-Matrix'
}

{ #category : #'as yet unclassified' }
NMNetwork >> backwardX: x y: y [

	| dZ2 dZ1 |
	dZ2 := a2 - y.
	dW2 := (dZ2 +* a1 transposed) collect: [ :v | v  / 4 ]. "/ number of examples"
	dB2 := dZ2 sumKeepDimension / 4. "/ number of examples"
	dZ1 := (w2 transposed +* dZ2) multiplyPerElement: (a1 collect: [ :v | v * (1 - v) ] ).
	dW1 := dZ1 +* x transposed / 4. "/ number of examples"
	dB1 := dZ1 sumKeepDimension / 4. "/ number of examples"

]

{ #category : #initialization }
NMNetwork >> computeCost: mat and: y [
"  cost = -np.sum(np.multiply(Y, np.log(A2)) +  np.multiply(1-Y, np.log(1-A2)))/m
  cost = np.squeeze(cost)
"
	| cost part1 part2 |
	part1 := y multiplyPerElement: (mat collect: #ln).
	part2 := (y collect: [ :v | 1 - v ]) multiplyPerElement: (mat collect: [ :v | (1 - v) ln ]).
	cost := (part1 + part2) sum negated / 4. "m = number of training examples"
	^ cost 
]

{ #category : #initialization }
NMNetwork >> configure: nbOfInputs hidden: nbOfNeurons nbOfOutputs: nbOfOutputs [
    "Configure the network with the given parameters
    The network has only one hidden layer"
 
	random := Random seed: 42.
   w1 := MMatrix newRows: nbOfNeurons columns: nbOfInputs.
	w1 random: random.
	b1 := MMatrix newRows: nbOfNeurons columns: 1.
	b1 random: random.
	
   w2 := MMatrix newRows: nbOfOutputs columns: nbOfNeurons.
	w2 random: random.
	b2 := MMatrix newRows: nbOfOutputs columns: 1.
	b2 random: random.
	

	"For debugging"
"	w1 fromContents:  { 0.04555144 .  -0.43483015 . -1.95379641 . -1.58688169 . -1.07445552 . -0.61722311}.
	b1 fromContents: { 0 .0 .0 }.
	w2 fromContents:  {-1.50100687 .  0.8935898 .  0.73954567}.
	b2 fromContents: { 0 }."
]

{ #category : #'as yet unclassified' }
NMNetwork >> example01 [
	<script: 'self new example01 inspect'>
	
	| n x y |
	x := MMatrix newRows: 2 columns: 4.
	x fromContents: #(0 1 0 1 0 0 1 1).
	
	y := MMatrix newRows: 1 columns: 4.
	y fromContents: #(0 0 0 1).
	
	n := NMNetwork new configure: 2 hidden: 3 nbOfOutputs: 1.
	n modelX: x y: y nbOfEpochs: 1000.
	^ n
]

{ #category : #initialization }
NMNetwork >> feed: inputs [
	| mat |
	"mat := MMatrix newFromVector: inputs."
	mat := inputs.
	

"
	w1 fromContents:  { 0.04555144 .  -0.43483015 . -1.95379641 . -1.58688169 . -1.07445552 . -0.61722311}.
	b1 fromContents: { 0 .0 .0 }.
	w2 fromContents:  {-1.50100687 .  0.8935898 .  0.73954567}.
	b2 fromContents: { 0 }.
"
	a1 := (w1 +* mat + b1) collect: [ :v | 1 / (1 + v negated exp) ].
	"a1 := z1 collect: [ :v | v exp - v negated exp / (v exp + v negated exp) ]."
	a2 := (w2 +* a1 + b2) collect: [ :v | 1 / (1 + v negated exp) ].
	^ a2
]

{ #category : #'as yet unclassified' }
NMNetwork >> modelX: x y: y nbOfEpochs: nbEpochs [

	| cost |
	errors := OrderedCollection new.
	nbEpochs timesRepeat: [ 
		a2 := self feed: x.
		cost := self computeCost: a2 and: y.
		self backwardX: x  y: y.
		self update.
		errors add: cost.
	].
	^ cost
]

{ #category : #'as yet unclassified' }
NMNetwork >> update [
	| lr |
	lr := 0.3.
	w1 := w1 - (dW1 * lr).
	b1 := b1 - (dB1 * lr).
	w2 := w2 - (dW2 * lr).
	b2 := b2 - (dB2 * lr).
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
