Class {
	#name : #CPlatform,
	#superclass : #CVisualElement,
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CPlatform >> createElement [
	element := RTBox new width: 1000; height: 10; color: Color gray trans; element.
	element @ RTDraggable	
]
