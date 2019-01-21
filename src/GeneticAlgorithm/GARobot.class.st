Class {
	#name : #GARobot,
	#superclass : #Object,
	#instVars : [
		'position',
		'map'
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
	orders
		do: [ :direction | 
			possiblePosition := position + (d at: direction).
			(map gridAt: possiblePosition) == #empty
				ifTrue: [ position := possiblePosition. path add: position ] ].
	^ path
]

{ #category : #accessing }
GARobot >> map: aMap [
	"Set the map where the robot lives in"
	map := aMap
]

{ #category : #accessing }
GARobot >> position [
	^ position
]

{ #category : #accessing }
GARobot >> position: aPoint [
	position := aPoint
]
