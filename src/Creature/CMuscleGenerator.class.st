Class {
	#name : #CMuscleGenerator,
	#superclass : #Object,
	#instVars : [
		'random',
		'minStrength',
		'deltaStrength',
		'minLength',
		'deltaLength',
		'minTime',
		'deltaTime'
	],
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CMuscleGenerator >> createMuscleFrom: aNode to: anotherNode [
	| m |
	m := CMuscle new.
	m node1: aNode.
	m node2: anotherNode.
	m length1: self generateLength.
	m length2: self generateLength.
	m time1: self generateTime.
	m time2: 200.
	m strenght: self generateStrenght.
	^ m
]

{ #category : #accessing }
CMuscleGenerator >> deltaLength [
	^ deltaLength
]

{ #category : #accessing }
CMuscleGenerator >> deltaLength: anObject [
	deltaLength := anObject
]

{ #category : #accessing }
CMuscleGenerator >> deltaStrength [
	^ deltaStrength
]

{ #category : #accessing }
CMuscleGenerator >> deltaStrength: anObject [
	deltaStrength := anObject
]

{ #category : #accessing }
CMuscleGenerator >> deltaTime [
	^ deltaTime
]

{ #category : #accessing }
CMuscleGenerator >> deltaTime: anObject [
	deltaTime := anObject
]

{ #category : #'as yet unclassified' }
CMuscleGenerator >> generateLength [
	^ minLength + (random nextInt: deltaLength)
]

{ #category : #'as yet unclassified' }
CMuscleGenerator >> generateStrenght [
	^ random next * deltaStrength + minStrength
]

{ #category : #'as yet unclassified' }
CMuscleGenerator >> generateTime [
	^ (random nextInt: deltaTime) + minTime
]

{ #category : #initialization }
CMuscleGenerator >> initialize [
	super initialize.
	random := Random seed: 42.
	
	minLength := 10.
	deltaLength := 30.
	minTime := 4.
	deltaTime := 200.
	minStrength := 1.
	deltaStrength := 3
]

{ #category : #'public - serialization' }
CMuscleGenerator >> materialize: values inMuscle: aMuscle [
	aMuscle length1: values first.
	aMuscle length2: values second.
	aMuscle strenght: values third.
	aMuscle time1: values fourth.
	aMuscle time2: values fifth
]

{ #category : #accessing }
CMuscleGenerator >> minLength [
	^ minLength
]

{ #category : #accessing }
CMuscleGenerator >> minLength: anObject [
	minLength := anObject
]

{ #category : #accessing }
CMuscleGenerator >> minStrength [
	^ minStrength
]

{ #category : #accessing }
CMuscleGenerator >> minStrength: anObject [
	minStrength := anObject
]

{ #category : #accessing }
CMuscleGenerator >> minTime [
	^ minTime
]

{ #category : #accessing }
CMuscleGenerator >> minTime: anObject [
	minTime := anObject
]

{ #category : #accessing }
CMuscleGenerator >> random [
	^ random
]

{ #category : #accessing }
CMuscleGenerator >> random: anObject [
	random := anObject
]

{ #category : #'public - serialization' }
CMuscleGenerator >> serializeMuscle: aMuscle [
	^ Array
		with: aMuscle length1
		with: aMuscle length2
		with: aMuscle strenght
		with: aMuscle time1
		with: aMuscle time2
]

{ #category : #'public - serialization' }
CMuscleGenerator >> valueForIndex: anIndex [
	| i |
	i := (anIndex - 1) % 5.
	i = 0 ifTrue: [ ^ self generateLength ].
	i = 1 ifTrue: [ ^ self generateLength ].
	i = 2 ifTrue: [ ^ self generateStrenght ].
	i = 3 ifTrue: [ ^ self generateTime ].
	i = 4 ifTrue: [ ^ self generateTime ].
	self error: 'Should not be here'
]
