Class {
	#name : #CBasicTest,
	#superclass : #TestCase,
	#category : #Creature
}

{ #category : #tests }
CBasicTest >> testBasic [
	| creature c muscles |
	creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
	c := CCanvas new.
	c addCreature: creature.
	c open delete.
	
	self assert: c element numberOfElements equals: 3.
	self assert: c element numberOfEdges equals: 3.
	
	muscles := creature muscles.
	self assert: (muscles collect: [ :m | { m node1 . m node2 } ]) asSet size equals: 3.
]

{ #category : #tests }
CBasicTest >> testReachStable [

	| creature c |
	creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
	c := CCanvas new.
	c addCreature: creature.
	creature reachStable.
	(CMuscle new maxTime * 2) timesRepeat: [ creature beat ]
]
