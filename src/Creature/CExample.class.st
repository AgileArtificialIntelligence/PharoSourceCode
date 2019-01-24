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

{ #category : #'as yet unclassified' }
CExample >> example03WithBone [
	<script: 'self new example03WithBone'>

| creature c mg |
mg := CMuscleGenerator new.
mg minLength: 30.
mg deltaLength: 10.

creature := CCreature new.
creature muscleGenerator: mg.
creature configureNodes: 4.
creature addBoneFromIndex: 1 toIndex: 2.
creature addBoneFromIndex: 2 toIndex: 3.
creature addBoneFromIndex: 1 toIndex: 3 length: 40.
creature addBoneFromIndex: 3 toIndex: 4.

creature addMuscleFromIndex: 2 toIndex: 4.

creature createElements.
"creature shuffleNodes."

creature nodes first translateBy: 20 @ 0.
creature nodes second translateBy: 0 @ -10.
creature nodes third translateBy: -10 @ 0.
creature nodes fourth translateBy: 0 @ 10.

"creature beat.
creature bones.
creature nodes collect: #position.
"
c := CCanvas new.
c addCreature: creature.
c addPlatform: CPlatform new.
c open
]
