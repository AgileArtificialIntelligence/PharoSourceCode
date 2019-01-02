Class {
	#name : #CNode,
	#superclass : #CVisualElement,
	#instVars : [
		'friction',
		'disp'
	],
	#category : #Creature
}

{ #category : #accessing }
CNode >> addToDisp: d [
	disp := disp + d
]

{ #category : #accessing }
CNode >> beat [
	
]

{ #category : #'as yet unclassified' }
CNode >> createElement [
	element := RTEllipse new size: 10; color: Color red trans; element.
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
