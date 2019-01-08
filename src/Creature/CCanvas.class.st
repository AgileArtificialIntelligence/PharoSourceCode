Class {
	#name : #CCanvas,
	#superclass : #CVisualElement,
	#instVars : [
		'creatures',
		'time',
		'platforms'
	],
	#category : #Creature
}

{ #category : #accessing }
CCanvas >> addCreature: aCreature [
	creatures add: aCreature.
	element addAll: (aCreature nodes collect: #element).
	element addAll: (aCreature muscles collect: #element).
]

{ #category : #accessing }
CCanvas >> addPlatform: aPlatform [
	platforms add: aPlatform.
	aPlatform createElement.
	element add: aPlatform element.
]

{ #category : #accessing }
CCanvas >> beat [	
	time := time + 1.
	creatures do: [ :c | c beat; checkForCollision: platforms ]
]

{ #category : #'as yet unclassified' }
CCanvas >> createElement [
	element := RTView new.
]

{ #category : #initialization }
CCanvas >> initialize [
	super initialize.
	creatures := OrderedCollection new.
	platforms := OrderedCollection new. 
	time := 0.
	self createElement
]

{ #category : #accessing }
CCanvas >> open [
	| lbl |
	creatures do: #resetPosition.

	lbl := (RTLabel new elementOn: time) setAsFixed; yourself.
	element add: lbl.
	lbl translateBy: 80 @ 30.
	element
		addAnimation:
			(RTActiveAnimation new
				intervalInMilliseconds: 10;
				blockToExecute: [ 
					self beat.
					lbl trachelShape text: time asString.
					element signalUpdate ]).
	^ element open
]
