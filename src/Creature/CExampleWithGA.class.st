Class {
	#name : #CExampleWithGA,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #'genetic algorithm' }
CExampleWithGA >> result02 [

"mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAEngine new.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 15 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 1000.
g numberOfGenes: 3 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
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
creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
"creature materialize: g result."
	creature materialize:  #(54 86 4.939039338118881 50 46 12 14 2.1024524874996637 186 77 70 87 3.5876934901288213 83 89).
	creature resetPosition.
	c := CCanvas new.
	c addPlatform: CPlatform new.
	c addCreature: creature.
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
	creature materialize: #(57 61 2.948715797834432 137 49 31 28 1.92998272247146 54 217 30 88 3.4641803516839538 67 128 87 82 3.2223055156517333 209 166 18 13 4.318311728918139 216 57).
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
	creature materialize: #(84 86 4.847119399508051 134 148 58 12 6.253399093054886 26 65 20 21 1.7179966076361 87 61 37 41 1.981972552594716 131 102 24 25 4.620223951116309 85 65).
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
