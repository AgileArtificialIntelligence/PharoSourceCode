Class {
	#name : #CVisualElement,
	#superclass : #Object,
	#instVars : [
		'element'
	],
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CVisualElement >> createElement [
	self subclassResponsibility 
	
]

{ #category : #accessing }
CVisualElement >> element [
	^ element
]
