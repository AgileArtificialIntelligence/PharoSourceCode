Class {
	#name : #CExample,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CExample >> example01 [
	<script: 'self new example01'>

| mg creature c |
mg := CMuscleGenerator new.
mg minStrength: 0.3.
mg deltaStrength: 0.4.
mg minLength: 30.



creature := CCreature new.
creature muscleGenerator: mg.
creature configureWormWithBones: 4.

"creature beat.
creature bones.
creature nodes collect: #position.
"
c := CCanvas new.
c addCreature: creature.
c addPlatform: CPlatform new.
c open
]

{ #category : #'as yet unclassified' }
CExample >> example02VerySimple [
	<script: 'self new example02VerySimple'>

| creature c |
creature := CCreature new.
creature configureNodes: 3.
creature addBoneFromIndex: 1 toIndex: 2.
creature addBoneFromIndex: 2 toIndex: 3.

creature addMuscleFromIndex: 1 toIndex: 3.
creature createElements.
creature shuffleNodes.

"creature beat.
creature bones.
creature nodes collect: #position.
"
c := CCanvas new.
c addCreature: creature.
c addPlatform: CPlatform new.
c open
]
