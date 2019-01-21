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
GARobotMap >> drawRobotPath: aPath [
	aPath do: [ :pos | self gridAt: pos put: #robot ]
]

{ #category : #accessing }
GARobotMap >> exitPosition [
	^ (size - 1) @ (size - 1)
]

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
		self gridAt: x @ y put: #wall.
		self gridAt: (x @ y) + offsets first put: #wall.
		self gridAt: (x @ y) + offsets second put: #wall.
	].
	self fillStartAndEndPoints.
	1 to: size do: [ :i | 
		self gridAt: i @ 1 put: #wall. 
		self gridAt: 1 @ i put: #wall.
		self gridAt: size @ i put: #wall.
		self gridAt: i @ size put: #wall.
		 ] 
]

{ #category : #accessing }
GARobotMap >> fillStartAndEndPoints [
	self gridAt: self initialPosition put: #start.
	self gridAt: self exitPosition put: #end
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint [
	(self includesPoint: aPoint)
		ifFalse: [ ^ #empty ].
	^ (content at: aPoint y) at: aPoint x
]

{ #category : #accessing }
GARobotMap >> gridAt: aPoint put: value [
	(self includesPoint: aPoint)
		ifFalse: [ ^ self ].
	^ (content at: aPoint y) at: aPoint x put: value
]

{ #category : #accessing }
GARobotMap >> includesPoint: aPoint [
	^ (1 @ 1 extent: size @ size) containsPoint: aPoint
]

{ #category : #accessing }
GARobotMap >> initialPosition [
	^ 2 @ 2
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
	colors := Dictionary new.
	colors at: #empty put: Color white.
	colors at: #wall put: Color brown.
	colors at: #start put: Color red.
	colors at: #end put: Color green.
	colors at: #robot put: Color yellow.
	v := RTView new.
	shape := RTBox new size: 10; color: [ :c | colors at: c ].
	content do: [ :line | 
		v addAll: (shape elementsOn: line) @ RTPopup
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
	1 to: size do: [ :i | content at: i put: (Array new: aSize withAll: #empty) ].
	self fillStartAndEndPoints
]
