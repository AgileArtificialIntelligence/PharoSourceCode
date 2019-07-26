Class {
	#name : #FlattenLayer,
	#superclass : #Object,
	#instVars : [
		'previousLayer',
		'nextLayer',
		'outputs'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
FlattenLayer >> backPropagateError [
]

{ #category : #initialization }
FlattenLayer >> feed: inputs [
	outputs := inputs flatten
]
