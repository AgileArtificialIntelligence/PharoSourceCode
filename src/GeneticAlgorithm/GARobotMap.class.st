Class {
	#name : #GARobotMap,
	#superclass : #Object,
	#instVars : [
		'size',
		'content',
		'random'
	],
	#category : #'GeneticAlgorithm-Example-Robot'
}

{ #category : #accessing }
GARobotMap >> gridAt: aPoint [
	^ (content at: aPoint y) at: aPoint x
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint put: value [
	^ (content at: aPoint y) at: aPoint x put: value
]

{ #category : #accessing }
GARobotMap >> initialize [
	super initialize.
	random := Random seed: 42.
	self size: 30.
]

{ #category : #accessing }
GARobotMap >> rand: anInteger [
	^ random nextInt: anInteger
]

{ #category : #accessing }
GARobotMap >> size: aSize [
	size := aSize.
	content := Array new: aSize.
	1 to: size do: [ :i | content at: i put: (Array new: aSize withAll: 0) ]
]
