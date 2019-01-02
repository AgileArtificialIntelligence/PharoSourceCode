Class {
	#name : #CMuscle,
	#superclass : #CVisualElement,
	#instVars : [
		'node1',
		'node2',
		'contractedLength',
		'extendedTime',
		'contractedTime',
		'strenght',
		'extendedLength',
		'time'
	],
	#category : #Creature
}

{ #category : #accessing }
CMuscle >> beat [
	time := time + 1.
	time = self maxTime ifTrue: [ time := 0 ].

]

{ #category : #accessing }
CMuscle >> contractedLength [
	^ contractedLength
]

{ #category : #accessing }
CMuscle >> contractedLength: anObject [
	contractedLength := anObject
]

{ #category : #accessing }
CMuscle >> contractedTime [
	^ contractedTime
]

{ #category : #accessing }
CMuscle >> contractedTime: anObject [
	contractedTime := anObject
]

{ #category : #'as yet unclassified' }
CMuscle >> createElement [
	element := RTLine new color: Color gray trans; width: 5; edgeFrom: node1 element to: node2 element
]

{ #category : #accessing }
CMuscle >> delta [
	^ node2 element position - node1 element position
]

{ #category : #accessing }
CMuscle >> extendedLength [
	^ extendedLength
]

{ #category : #accessing }
CMuscle >> extendedLength: anObject [
	extendedLength := anObject
]

{ #category : #accessing }
CMuscle >> extendedTime [
	^ extendedTime
]

{ #category : #accessing }
CMuscle >> extendedTime: anObject [
	extendedTime := anObject
]

{ #category : #initialization }
CMuscle >> initialize [
	super initialize.
	strenght := 1.
	time := 0
]

{ #category : #accessing }
CMuscle >> length [
	^ 30
]

{ #category : #accessing }
CMuscle >> maxTime [
	^ 10
]

{ #category : #accessing }
CMuscle >> node1 [
	^ node1
]

{ #category : #accessing }
CMuscle >> node1: anObject [
	node1 := anObject
]

{ #category : #accessing }
CMuscle >> node2 [
	^ node2
]

{ #category : #accessing }
CMuscle >> node2: anObject [
	node2 := anObject
]

{ #category : #accessing }
CMuscle >> strenght [
	^ strenght
]

{ #category : #accessing }
CMuscle >> strenght: anObject [
	strenght := anObject
]

{ #category : #'as yet unclassified' }
CMuscle >> usesNodes: twoNodes [
	^ (node1 == twoNodes first and: [ node2 == twoNodes second ]) or: [ 
		node1 == twoNodes second and: [ node2 == twoNodes first ] ]
]
