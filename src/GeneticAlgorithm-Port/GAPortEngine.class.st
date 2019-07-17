"
g := GAPortEngine new.
	g port: port.
    g populationSize: 100.
        g numberOfGenes: 6.
    g createGeneBlock: [ :rand :index :ind | ($a to: $z) atRandom: rand ].
    g fitnessBlock: [ :genes | (#($m $a $t $t $e $o) with: genes  collect: [ :a :b | a = b 
                                            ifTrue: [ 1 ] ifFalse: [ 0 ] ]) sum ].

	  g run
	
mg := CMuscleGenerator new
		minStrength: 1.5;
		deltaStrength: 5;
		deltaTime: 200;
		minTime: 20;
		minLength: 10;
		deltaLength: 80.
g := GAPortEngine new.
g port: port.
""g := GAEngine new.""
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 15 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 100.
g numberOfGenes: 3 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	| creature c|
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
"
Class {
	#name : #GAPortEngine,
	#superclass : #GAEngine,
	#instVars : [
		'port'
	],
	#category : #'GeneticAlgorithm-Port'
}

{ #category : #accessing }
GAPortEngine >> initialize [
	super initialize.
	self selection: GAPortTournamentSelection new.
]

{ #category : #accessing }
GAPortEngine >> port [
	^ port 
]

{ #category : #accessing }
GAPortEngine >> port: aPort [
	port := aPort.
	selection port: aPort.
]

{ #category : #accessing }
GAPortEngine >> runMusclesExample [
| g mg |
g := self.
g crossoverOperator: (GAConstrainedCrossoverOperation new possibleCutpoints: (1 to: 15 by: 5)).
g mutationRate: 0.1.
g endForMaxNumberOfGeneration: 20.
g populationSize: 100.
g numberOfGenes: 3 * 5.
g createGeneBlock: [ :r :index | mg valueForIndex: index ].
g fitnessBlock: [ :genes |
	| creature c|
	creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
	"creature materialize: genes.
	creature resetPosition."
	c := CCanvas new.
	"c addPlatform: CPlatform new.
	c addCreature: creature.
	1000 timesRepeat: [ c beat ]."
	creature position x
].

^ g run.
]

{ #category : #accessing }
GAPortEngine >> runMusclesExample: mg [
	| g |
	g := self.
	g
		crossoverOperator:
			(GAConstrainedCrossoverOperation new
				possibleCutpoints: (1 to: 15 by: 5)).
	g mutationRate: 0.1.
	g endForMaxNumberOfGeneration: 20.
	g populationSize: 100.
	g numberOfGenes: 3 * 5.
	g createGeneBlock: [ :r :index | mg valueForIndex: index ].
	g
		fitnessBlock: [ :genes | 
			| creature c |
			creature := CCreature new configureNbNodes: 3 nbMuscles: 3.
			creature materialize: genes.
			creature resetPosition.
			c := CCanvas new.
			c addPlatform: CPlatform new.
			c addCreature: creature.
			1000 timesRepeat: [ c beat ].
			creature position x ].
	^ g run
]
