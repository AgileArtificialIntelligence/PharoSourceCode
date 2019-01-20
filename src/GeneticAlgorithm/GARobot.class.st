Class {
	#name : #GARobot,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'GeneticAlgorithm-Example-Robot'
}

{ #category : #accessing }
GARobot >> followPath: aPath [
	| d |
	d := Dictionary new.
	d at: $N put: (0 @ -1).
	d at: $S put: (0 @ 1).
	d at: $W put: (-1 @ 0).
	d at: $E put: (1 @ 0).
	aPath do: [ :direction |
		position := position + (d at: direction)
	]
]

{ #category : #accessing }
GARobot >> position [
	^ position
]

{ #category : #accessing }
GARobot >> position: aPoint [
	position := aPoint
]
