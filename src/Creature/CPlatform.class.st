Class {
	#name : #CPlatform,
	#superclass : #CVisualElement,
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CPlatform >> adjustNodeIfNecessary: node [
	"Answer whether the platform touch the node"

	| bottomNode topPlatform |
	bottomNode := node element encompassingRectangle bottomCenter y.
	topPlatform := self element encompassingRectangle topCenter y.

	topPlatform < bottomNode ifTrue: [ node translateBy: 0 @ (topPlatform - bottomNode) ]

]

{ #category : #'as yet unclassified' }
CPlatform >> createElement [
	element := RTBox new width: 1000; height: 10; color: Color gray trans; element.
	element @ RTDraggable	
]

{ #category : #'as yet unclassified' }
CPlatform >> touch: node [
	"Answer whether the platform touch the node"
	| bottomNode topPlatform |
	bottomNode := node element encompassingRectangle bottomCenter y.
	topPlatform := self element encompassingRectangle topCenter y.

	^ topPlatform <= bottomNode

]
