Class {
	#name : #GARobotExample,
	#superclass : #Object,
	#category : #'GeneticAlgorithm-Example-Robot'
}

{ #category : #running }
GARobotExample >> run [

| g |
g := GAEngine new.
g endForMaxNumberOfGeneration: 10.
g populationSize: 100.
g createGeneBlock: [ :rand :index :ind | #($N $S $W $E) atRandom: rand ].
g minimizeComparator.
g fitnessBlock: [ :genes |
	| distance d |
	distance := 0.
	2 to: genes size do: [ :pointIndex |
			d := (genes at: pointIndex) dist: (genes at: pointIndex - 1).
			distance := distance + (d ) ].
		distance
].
]
