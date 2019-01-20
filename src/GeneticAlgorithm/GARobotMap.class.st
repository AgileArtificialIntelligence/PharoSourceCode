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
GARobotMap >> fillDensity: density [
	"density is an integer"
	
	| offsets |
	density timesRepeat: [ 
		| x y |
		x := self rand: size.
		y := self rand: size.
		
		offsets := (self rand: 2) = 1 
			ifTrue: [ { 1 @ 0 . -1 @ 0 } ] 
			ifFalse: [ { 0 @ -1 . 0 @ -1 } ].
		self gridAt: x @ y put: 1.
		self gridAt: (x @ y) + offsets first put: 1.
		self gridAt: (x @ y) + offsets second put: 1.
	]
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint [
	^ (content at: aPoint y) at: aPoint x
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint put: value [
	(aPoint = (0 @ 0) or: [ aPoint = (size @ size) ]) ifTrue: [ ^ self ].
	(((1 @ 1) extent: (size @ size)) containsPoint: aPoint) ifFalse: [ ^ self ].
	^ (content at: aPoint y) at: aPoint x put: value
]

{ #category : #accessing }
GARobotMap >> initialize [
	super initialize.
	random := Random seed: 42.
	self size: 30.
]

{ #category : #accessing }
GARobotMap >> open [

	| v colors shape |
	colors := { Color white . Color black }.
	v := RTView new.
	shape := RTBox new size: 10; color: [ :c | colors at: (c + 1) ].
	content do: [ :line | 
		v addAll: (shape elementsOn: line)
	].
	RTGridLayout new gapSize: 0; lineItemsCount: size; on: v elements.
	^ v open
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
