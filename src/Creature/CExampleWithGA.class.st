Class {
	#name : #CExampleWithGA,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #running }
CExampleWithGA >> run [

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
