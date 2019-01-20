Class {
	#name : #GARobotExample,
	#superclass : #Object,
	#category : #'GeneticAlgorithm-Example-Robot'
}

{ #category : #running }
GARobotExample >> run [

| g robot  initialPosition target |

initialPosition := 0 @ 0.
target := 20 @ 20.

g := GAEngine new.
g endForMaxNumberOfGeneration: 10.
g populationSize: 100.
g createGeneBlock: [ :rand :index :ind | #($N $S $W $E) atRandom: rand ].
g minimizeComparator.
g fitnessBlock: [ :genes |
	robot position: initialPosition.
	robot followPath: genes.
	robot position dist: target
].
]
