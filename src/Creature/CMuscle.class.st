Class {
	#name : #CMuscle,
	#superclass : #CVisualElement,
	#instVars : [
		'node1',
		'node2',
		'contractedLength',
		'contractedTime',
		'extendedLength',
		'time',
		'strength'
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
CMuscle >> contractedTime: anInteger [
	contractedTime := anInteger
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

{ #category : #initialization }
CMuscle >> initialize [
	super initialize.
	strength := 5.
	time := 0
]

{ #category : #accessing }
CMuscle >> length [
	^ time < contractedTime
		ifTrue: [ contractedLength ]
		ifFalse: [ extendedLength ]
]

{ #category : #accessing }
CMuscle >> maxTime [
	^ 50
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
CMuscle >> strenght: anObject [
	strength := anObject
]

{ #category : #accessing }
CMuscle >> strength [
	^ strength
]

{ #category : #'as yet unclassified' }
CMuscle >> usesNodes: twoNodes [
	^ (node1 == twoNodes first and: [ node2 == twoNodes second ]) or: [ 
		node1 == twoNodes second and: [ node2 == twoNodes first ] ]
]
