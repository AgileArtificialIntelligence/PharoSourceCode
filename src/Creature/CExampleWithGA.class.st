Class {
	#name : #CExampleWithGA,
	#superclass : #Object,
	#category : #Creature
}

{ #category : #'as yet unclassified' }
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
