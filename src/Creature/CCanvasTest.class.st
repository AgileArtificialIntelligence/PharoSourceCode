Class {
	#name : #CCanvasTest,
	#superclass : #TestCase,
	#category : #Creature
}

{ #category : #tests }
CCanvasTest >> testBasic [
	| creature c |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 4.

	"creature muscles first extendedLength: 100; contractedLength: 5."
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ creature beat ]
]
