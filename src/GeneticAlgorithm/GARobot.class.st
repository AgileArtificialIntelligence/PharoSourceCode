Class {
	#name : #GARobot,
	#superclass : #Object,
	#instVars : [
		'position',
		'map',
		'foodTakens'
	],
	#category : #'GeneticAlgorithm-Example-Robot'
}

{ #category : #accessing }
GARobot >> followOrders: orders [
	| d possiblePosition path |
	d := Dictionary new.
	d at: $N put: 0 @ -1.
	d at: $S put: 0 @ 1.
	d at: $W put: -1 @ 0.
	d at: $E put: 1 @ 0.
	path := OrderedCollection new.
	path add: map initialPosition.
	self position: map initialPosition.
	foodTakens := OrderedCollection new.
	orders
		do: [ :direction | 
			possiblePosition := position + (d at: direction).
			(((map gridAt: possiblePosition) == #food) and: [ (foodTakens includes: possiblePosition) not ])
				ifTrue: [ foodTakens add: possiblePosition ].
			
			"If we found the exit, then we return"
			possiblePosition == map exitPosition ifTrue: [ ^ path ].
			
			
			(map gridAt: possiblePosition) ~= #wall
				ifTrue: [ position := possiblePosition.
					path add: position ] ].
	^ path
]

{ #category : #accessing }
GARobot >> initialize [
	super initialize.
	foodTakens := OrderedCollection new
]

{ #category : #accessing }
GARobot >> map: aMap [
	"Set the map where the robot lives in"
	map := aMap
]

{ #category : #accessing }
GARobot >> numberOfFoods [
	^ foodTakens size
]

{ #category : #accessing }
GARobot >> position [
	^ position
]

{ #category : #accessing }
GARobot >> position: aPoint [
	position := aPoint
]
