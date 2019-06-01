Class {
	#name : #NMLayer,
	#superclass : #Object,
	#instVars : [
		'w',
		'b',
		'delta',
		'dz',
		'dw',
		'db',
		'output',
		'previous',
		'next'
	],
	#category : #'NeuralNetwork-Matrix'
}

{ #category : #accessing }
NMLayer >> b [
	^ b
]

{ #category : #accessing }
NMLayer >> b: anObject [
	b := anObject
]

{ #category : #accessing }
NMLayer >> db [
	^ db
]

{ #category : #accessing }
NMLayer >> db: anObject [
	db := anObject
]

{ #category : #accessing }
NMLayer >> delta [
	^ delta
]

{ #category : #accessing }
NMLayer >> delta: anObject [
	delta := anObject
]

{ #category : #accessing }
NMLayer >> dw [
	^ dw
]

{ #category : #accessing }
NMLayer >> dw: anObject [
	dw := anObject
]

{ #category : #accessing }
NMLayer >> dz [
	^ dz
]

{ #category : #accessing }
NMLayer >> dz: anObject [
	dz := anObject
]

{ #category : #initialization }
NMLayer >> feed: mat [
	output := (w +* mat + b) collect: [ :v | 1 / (1 + v negated exp) ].
	^ output
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
NMLayer >> next: anObject [
	next := anObject
]

{ #category : #accessing }
NMLayer >> output [
	^ output
]

{ #category : #accessing }
NMLayer >> output: anObject [
	output := anObject
]

{ #category : #accessing }
NMLayer >> previous [
	^ previous
]

{ #category : #accessing }
NMLayer >> previous: anObject [
	previous := anObject
]

{ #category : #updating }
NMLayer >> update [
	| lr |
	lr := 0.3.
	w := w - ((dz +* previous output transposed) * lr * (1 / 4)).
	b := b - (dz sumKeepDimension * lr * (1 / 4)).

	
"	w := w - (dw * lr).
	b := b - (db * lr).
"	
	next ifNotNil: [ next update ]
]

{ #category : #updating }
NMLayer >> update: input [
	| lr |
	lr := 0.3.
	w := w - ((dz +* input transposed) * lr * (1 / input nbColumns)).
	b := b - (dz sumKeepDimension * lr * (1 / input nbColumns)).
		
	next update
	"w := w - (dw * lr).
	b := b - (db * lr).
"
]

{ #category : #accessing }
NMLayer >> w [
	^ w
]

{ #category : #accessing }
NMLayer >> w: anObject [
	w := anObject
]
