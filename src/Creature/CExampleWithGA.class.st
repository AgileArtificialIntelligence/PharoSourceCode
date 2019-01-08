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
CExampleWithGA >> result04 [
"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 25 by: 5)).
g selection: (GATournamentSelection new tournamentSize: 30).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 30.
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
g."

| c creature |

creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
	creature materialize: #(88 89 2.216418407725365 34 51 36 32 3.5333692184804795 198 25 14 20 1.5037983222882256 99 81 44 45 1.5524069508781688 30 49 90 19 6.460385386347951 67 72).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	c open


 
]

{ #category : #'genetic algorithm' }
CExampleWithGA >> result05 [
"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 8*5 by: 5)).
g selection: (GATournamentSelection new tournamentSize: 30).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 30.
g populationSize: 1000.
g numberOfGenes: 8 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 6 nbMuscles: 8.
	creature materialize: genes.
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ].
	creature position x
].
g run. 
g."

| creature c |
creature := CCreature new configureNbNodes: 6 nbMuscles: 8.
	creature materialize: #(71 76 2.9511110756784262 67 159 13 25 4.056027300914762 115 109 89 49 5.323848927311529 26 30 28 27 3.6052427459998255 173 213 17 12 5.712459558254322 122 196 85 62 3.1004695238547724 113 67 12 16 2.3213147152314497 140 95 27 17 5.637003838148435 174 209).
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
