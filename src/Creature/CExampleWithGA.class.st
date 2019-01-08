Class {
	#name : #CExampleWithGA,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #'genetic algorithm' }
CExampleWithGA >> result01 [
"
pop: 400
beat: 1000
"
"cr := CCreature new configureNbNodes: 2 nbMuscles: 1."

| cr c |
cr := CCreature new configureNbNodes: 4 nbMuscles: 5.
cr materialize: #(13 32 4 36 40 4 23 29 5 40 16 5 39 19 3).

c := CCanvas new.
c addCreature: cr.
c addPlatform: CPlatform new.
c open
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result02 [
"
pop: 1000
beat: 600
"

| cr c |
cr := CCreature new configureNbNodes: 6 nbMuscles: 8.
cr materialize: #(18 23 6 40 33 3 28 17 4 23 27 4 14 37 6 39 13 3 40 14 5 17 28 3).

c := CCanvas new.
c addCreature: cr.
c addPlatform: CPlatform new.
c open
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result03 [
"
pop: 1000
beat: 600


mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 25 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 1000.
g numberOfGenes: 5 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].

[g run ] timeToRun.
g
"

| c creature |

creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: #(39 39 2.3072576722163975 29 137 33 45 3.62520734738801 21 143 90 12 2.1720258182250083 122 56 80 81 3.3322168974355875 178 35 15 14 3.402695832263071 54 200).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open

]

{ #category : #'genetic algorithm' }
CExampleWithGA >> run [

| g creature c mg |
mg := CMuscleGenerator new
		minStrength: 3;
		deltaStrength: 8.
g := GAEngine new.
g populationSize: 100.
g numberOfGenes: 5 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: genes.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	50 timesRepeat: [ c beat ].
	creature position x
].

g run.

(g logs collect: #fitness) plot.

g result "#(35 16 6 32 28 5 18 24 6 13 11 3)"
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> runOLD [

| g creature c |
g := GAEngine new.
g populationSize: 100.
g numberOfGenes: 4 * 3.
g createGeneBlock: [ :r :index |
	(index - 1 % 3) == 0 
		ifTrue: [ 10 + (r nextInt: 30) ]
		ifFalse: [ (index - 1 % 3) == 1 
							ifTrue: [  10 + (r nextInt: 30)  ]
							ifFalse: [ (r nextInt: 4) + 2 ] ]
].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 4 nbMuscles: 4.
	creature materialize: genes.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	50 timesRepeat: [ c beat ].
	creature position x
].

g run.

(g logs collect: #fitness) plot.

g result "#(35 16 6 32 28 5 18 24 6 13 11 3)"
]

{ #category : #simple }
CExampleWithGA >> simpleExample01 [
	| mg cr c |
	mg := CMuscleGenerator new
		minStrength: 3;
		deltaStrength: 8.
	cr := CCreature new
		muscleGenerator: mg;
		configureNbNodes: 4 nbMuscles: 5.
	c := CCanvas new.
	c addCreature: cr.
	c addPlatform: CPlatform new.
	c open
]
