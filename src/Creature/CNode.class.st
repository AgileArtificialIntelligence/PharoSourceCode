Class {
	#name : #CNode,
	#superclass : #CVisualElement,
	#instVars : [
		'friction',
		'disp',
		'speedVector'
	],
	#category : #Creature
}

{ #category : #accessing }
CNode >> addToDisp: d [
	disp := disp + d
]

{ #category : #accessing }
CNode >> beat [
	self translateBy: speedVector.
	speedVector := speedVector + (0 @ self gravity).
	
]

{ #category : #accessing }
CNode >> checkForCollision: platforms [
"(platforms anySatisfy: [ :p | p touch: self ]) ifTrue: [ speedVector := 0 @ 0 ].
	"
	platforms
		do: [ :p | 
			(p touch: self)
				ifTrue: [ speedVector := 0 @ 0.
					p adjustNodeIfNecessary: self ] ]
]

{ #category : #'as yet unclassified' }
CNode >> createElement [
	element := RTEllipse new size: self nodeSize; color: Color red trans; element.
	element @ RTDraggable	
]

{ #category : #accessing }
CNode >> disp [
	^ disp
]

{ #category : #accessing }
CNode >> disp: aPoint [
	disp := aPoint
]

{ #category : #accessing }
CNode >> gravity [
	^ 0.01
]

{ #category : #initialization }
CNode >> initialize [
	super initialize.
	speedVector := 0 @ 0
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
CNode >> resetDisp [
	disp := 0.
]

{ #category : #accessing }
CNode >> translateBy: aPoint [
	element translateBy: aPoint
]

{ #category : #accessing }
CNode >> translateTo: aPoint [
	element translateTo: aPoint
]
