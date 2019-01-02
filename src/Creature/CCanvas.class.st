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
	platforms := OrderedCollection new. 
	time := 0.
	self createElement
]

{ #category : #accessing }
CCanvas >> open [

	creatures do: [ :c | c translateTo: 0 @ -100 ].

	element
		addAnimation:
			(RTActiveAnimation new
				intervalInMilliseconds: 10;
				blockToExecute: [ 
					self beat.
					element signalUpdate ]).
	^ element open
]
