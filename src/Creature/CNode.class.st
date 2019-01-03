Class {
	#name : #CNode,
	#superclass : #CVisualElement,
	#instVars : [
		'friction',
		'speedVector',
		'isOnGround'
	],
	#category : #Creature
}

{ #category : #accessing }
CNode >> beat [
	self translateBy: speedVector / 5.
	speedVector := speedVector + (0 @ self gravity).
	
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
	^ 1
]

{ #category : #initialization }
CNode >> initialize [
	super initialize.
	speedVector := 0 @ 0.
	isOnGround := false
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
CNode >> translateBy: aPoint [
	element translateBy: aPoint
]

{ #category : #accessing }
CNode >> translateTo: aPoint [
	element translateTo: aPoint
]
