Class {
	#name : #CMuscle,
	#superclass : #CVisualElement,
	#instVars : [
		'node1',
		'node2',
		'time',
		'length1',
		'length2',
		'time1',
		'time2',
		'strenght'
	],
	#category : #Creature
}

{ #category : #accessing }
CMuscle >> beat [
	time := time + 1.
	time = self maxTime ifTrue: [ time := 0 ].

]

{ #category : #'as yet unclassified' }
CMuscle >> createElement [
	element := RTLine new color: Color gray trans; width: 5; edgeFrom: node1 element to: node2 element
]

{ #category : #accessing }
CMuscle >> delta [
	^ node2 element position - node1 element position
]

{ #category : #initialization }
CMuscle >> initialize [
	super initialize.
	time := 0
]

{ #category : #accessing }
CMuscle >> length [
	"Maybe rename it to ideal length"
	^ time < self minTime
		ifTrue: [ length1 ]
		ifFalse: [ length2 ]
]

{ #category : #accessing }
CMuscle >> length1 [
	^ length1
]

{ #category : #accessing }
CMuscle >> length1: aLengthAsInteger [
	length1 := aLengthAsInteger
]

{ #category : #accessing }
CMuscle >> length2 [
	^ length2
]

{ #category : #accessing }
CMuscle >> length2: aLengthAsInteger [
	length2 := aLengthAsInteger
]

{ #category : #accessing }
CMuscle >> maxTime [
	^ time1 max: time2
]

{ #category : #accessing }
CMuscle >> minTime [
	^ time1 min: time2
]

{ #category : #accessing }
CMuscle >> node1 [
	^ node1
]

{ #category : #accessing }
CMuscle >> node1: aNode [
	node1 := aNode
]

{ #category : #accessing }
CMuscle >> node2 [
	^ node2
]

{ #category : #accessing }
CMuscle >> node2: aNode [
	node2 := aNode
]

{ #category : #accessing }
CMuscle >> strenght [
	^ strenght
]

{ #category : #accessing }
CMuscle >> strenght: aStrenghtAsFloat [
	strenght := aStrenghtAsFloat
]

{ #category : #accessing }
CMuscle >> time [
	^ time
]

{ #category : #accessing }
CMuscle >> time1 [
	^ time1
]

{ #category : #accessing }
CMuscle >> time1: anInteger [
	time1 := anInteger
]

{ #category : #accessing }
CMuscle >> time2 [
	^ time2
]

{ #category : #accessing }
CMuscle >> time2: anInteger [
	time2 := anInteger
]

{ #category : #accessing }
CMuscle >> time: aTimeAsInteger [
	time := aTimeAsInteger
]

{ #category : #'as yet unclassified' }
CMuscle >> usesNodes: twoNodes [
	^ (node1 == twoNodes first and: [ node2 == twoNodes second ]) or: [ 
		node1 == twoNodes second and: [ node2 == twoNodes first ] ]
]
