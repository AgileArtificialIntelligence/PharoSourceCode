Class {
	#name : #CBone,
	#superclass : #CConnection,
	#instVars : [
		'length'
	],
	#category : #Creature
}

{ #category : #accessing }
CBone >> beat [
]

{ #category : #'as yet unclassified' }
CBone >> createElement [
	element := RTLine new color: Color gray trans; width: 5; edgeFrom: node1 element to: node2 element
]

{ #category : #accessing }
CBone >> length [
	^ length
]

{ #category : #accessing }
CBone >> length: aLength [
	length := aLength
]

{ #category : #accessing }
CBone >> strenght [
	^ 2
]
