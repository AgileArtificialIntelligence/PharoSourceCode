Class {
	#name : #NMLayer,
	#superclass : #Object,
	#instVars : [
		'w',
		'b',
		'delta',
		'output',
		'previous',
		'next',
		'lr',
		'numberOfExamples'
	],
	#category : #'NeuralNetwork-Matrix'
}

{ #category : #accessing }
NMLayer >> b [
	^ b
]

{ #category : #accessing }
NMLayer >> b: biasVector [
	b := biasVector
]

{ #category : #accessing }
NMLayer >> delta [
	^ delta
]

{ #category : #accessing }
NMLayer >> delta: deltaMatrix [
	delta := deltaMatrix
]

{ #category : #initialization }
NMLayer >> feed: inputMatrix [
	output := (w +* inputMatrix + b) collect: [ :v | 1 / (1 + v negated exp) ].
	^ output
]

{ #category : #initialization }
NMLayer >> initialize [
	super initialize.
	lr := 0.1
]

{ #category : #accessing }
NMLayer >> lr [
	^ lr
]

{ #category : #accessing }
NMLayer >> lr: aLearningRate [
	lr := aLearningRate
]

{ #category : #'as yet unclassified' }
NMLayer >> nbInputs: nbOfNeurons nbOutputs: nbOfInputs random: random [
   w := MMatrix newRows: nbOfNeurons columns: nbOfInputs.
	w random: random.
	b := MMatrix newRows: nbOfNeurons columns: 1.
	b random: random.
	
]

{ #category : #accessing }
NMLayer >> next [
	^ next
]

{ #category : #accessing }
NMLayer >> next: aLayer [
	next := aLayer
]

{ #category : #accessing }
NMLayer >> numberOfExamples [
	^ numberOfExamples
]

{ #category : #accessing }
NMLayer >> numberOfExamples: anObject [
	numberOfExamples := anObject
]

{ #category : #accessing }
NMLayer >> output [
	^ output
]

{ #category : #accessing }
NMLayer >> previous [
	^ previous
]

{ #category : #accessing }
NMLayer >> previous: aLayer [
	previous := aLayer
]

{ #category : #updating }
NMLayer >> update [
	w := w - ((delta +* previous output transposed) * lr / numberOfExamples ).
	b := b - (delta sumKeepDimension * lr / numberOfExamples).
	next ifNotNil: [ next update ]
]

{ #category : #updating }
NMLayer >> update: input [
	w := w - ((delta +* input transposed) * lr / numberOfExamples).
	b := b - (delta sumKeepDimension * lr / numberOfExamples).
	next update

]

{ #category : #accessing }
NMLayer >> w [
	^ w
]

{ #category : #accessing }
NMLayer >> w: matrixForWeights [
	w := matrixForWeights
]
