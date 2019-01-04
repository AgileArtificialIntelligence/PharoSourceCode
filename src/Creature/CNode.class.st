Class {
	#name : #CNode,
	#superclass : #CVisualElement,
	#instVars : [
		'friction',
		'speedVector',
		'force',
		'isOnGround',
		'gravityForce'
	],
	#category : #Creature
}

{ #category : #initialization }
CNode >> addForce: aForceAsPoint [
	force := force + aForceAsPoint
]

{ #category : #accessing }
CNode >> beat [
	speedVector := speedVector + gravityForce + force. 
	self translateBy: speedVector
	
"	| previousPosition |
	previousPosition := element position.
	Transcript show: self printString; show: '  '; show: previousPosition asString; cr.
	self translateBy: speedVector / 5.
	speedVector := speedVector + (0 @ self gravity).
	"
]

{ #category : #accessing }
CNode >> checkForCollision: platforms [
	"(platforms anySatisfy: [ :p | p touch: self ]) ifTrue: [ speedVector := 0 @ 0 ].
	"

	isOnGround := false.
	platforms
		do: [ :p | 
			(p touch: self)
				ifTrue: [ 
					speedVector := 0 @ 0.
					p adjustNodeIfNecessary: self.
					isOnGround := true ] ]
]

{ #category : #'as yet unclassified' }
CNode >> createElement [
	element := RTEllipse new size: self nodeSize; color: Color red trans; element.
	element @ RTDraggable	
]

{ #category : #accessing }
CNode >> gravity [
	^ 2
]

{ #category : #accessing }
CNode >> gravityForce [
	^ gravityForce
]

{ #category : #initialization }
CNode >> initialize [
	super initialize.
	speedVector := 0 @ 0.
	isOnGround := false.
	force := 0 @ 0.
	gravityForce := 0 @ self gravity.
]

{ #category : #accessing }
CNode >> isOnGround [
	^ isOnGround
]

{ #category : #'as yet unclassified' }
CNode >> nodeSize [
	^ 10
]

{ #category : #accessing }
CNode >> position [
	^ element position
]

{ #category : #printing }
CNode >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self hash asString.
	str nextPut: $>.
]

{ #category : #accessing }
CNode >> resetSpeed [
	speedVector := 0
]

{ #category : #accessing }
CNode >> translateBy: aPoint [
self haltIf: [ aPoint x isNaN ].
self haltIf: [ aPoint y isNaN ].

self haltIf: [ element position x isNaN ].
self haltIf: [ element position y isNaN ].
	element translateBy: aPoint.
	

self haltIf: [ element position x isNaN ].
self haltIf: [ element position y isNaN ].
]

{ #category : #accessing }
CNode >> translateTo: aPoint [
self haltIf: [ aPoint x isNaN ].
self haltIf: [ aPoint y isNaN ].
	element translateTo: aPoint.
	
self haltIf: [ element position x isNaN ].
self haltIf: [ element position y isNaN ].
]
