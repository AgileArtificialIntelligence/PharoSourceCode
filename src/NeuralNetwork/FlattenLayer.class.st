Class {
	#name : #FlattenLayer,
	#superclass : #Object,
	#instVars : [
		'previousLayer',
		'nextLayer',
		'outputs',
		'width',
		'height',
		'depth',
		'deltas'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
FlattenLayer >> backwardPropagateError [

	| delta |
	delta := outputs collectWithIndex: [ :output :j |
        | theError |
        theError := 0.0.
        self nextLayer neurons do: [ :nextNeuron |
            theError := theError + ((nextNeuron weights at: j) * nextNeuron delta)
        ].
        theError].
	deltas := self backwardReconstruct: delta.
	
	self previousLayer notNil ifTrue: [ self previousLayer backwardAssignError ].
]

{ #category : #'as yet unclassified' }
FlattenLayer >> backwardReconstruct: output [
	"To reconstruct input structure with output vector."

	^ (1 to: width) collect: [ :i |
		(1 to: height) collect: [ :j |
			(1 to: depth) collect: [ :k | output at: ((i - 1) * depth * width + ((j - 1) * height) + k) ]]]
]

{ #category : #accessing }
FlattenLayer >> deltas [
	"To get the deltas attribute."

	^ deltas
]

{ #category : #initialization }
FlattenLayer >> feed: inputs [

	width := inputs size.
	height := inputs anyOne size.
	depth := inputs anyOne anyOne size.
	outputs := inputs flattened.
	^ nextLayer ifNotNil: [ nextLayer feed: outputs ]
]

{ #category : #accessing }
FlattenLayer >> nextLayer [
	"To get the next layer of the current layer."

	^ nextLayer
]

{ #category : #accessing }
FlattenLayer >> nextLayer: aLayer [
	"To set the next layer of the current layer."

	nextLayer := aLayer
]

{ #category : #accessing }
FlattenLayer >> outputs [
	"To get output attribute."

	^ outputs
]

{ #category : #accessing }
FlattenLayer >> previousLayer [
	"To get the previous layer of the current layer."

	^ previousLayer
]

{ #category : #accessing }
FlattenLayer >> previousLayer: aLayer [
	"To set the previous layer of the current layer."

	previousLayer := aLayer
]

{ #category : #accessing }
FlattenLayer >> stride [
	"Just for uniform the messages."

	^ 1
]
