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
	robot followOrders: genes.
	robot position dist: target
].
]

{ #category : #running }
GARobotExample >> runMap [
	<script: 'self new runMap'>

	| map robot g |
	map := GARobotMap new fillDensity: 80.
	robot := GARobot new.
	robot map: map.
	g := GAEngine new.
	g endForMaxNumberOfGeneration: 10.
	g numberOfGenes: 100.
	g populationSize: 250.
	g createGeneBlock: [ :rand :index :ind | #($N $S $W $E) atRandom: rand ].
	g minimizeComparator.
	g
		fitnessBlock: [ :genes | 
			robot followOrders: genes.
			robot position dist: map exitPosition ].
	g run.

	map drawRobotPath: (robot followOrders: g result).
	map open
]
