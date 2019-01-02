Class {
	#name : #CCanvas,
	#superclass : #CVisualElement,
	#instVars : [
		'creatures',
		'time'
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
CCanvas >> beat [	
	creatures do: #beat.
]

{ #category : #'as yet unclassified' }
CCanvas >> createElement [
	element := RTView new.
]

{ #category : #initialization }
CCanvas >> initialize [
	super initialize.
	creatures := OrderedCollection new.
	time := 0.
	self createElement
]

{ #category : #accessing }
CCanvas >> open [
	element
		addAnimation:
			(RTActiveAnimation new
				intervalInMilliseconds: 10;
				blockToExecute: [ 
					self beat.
					element signalUpdate ]).
	^ element open
]
