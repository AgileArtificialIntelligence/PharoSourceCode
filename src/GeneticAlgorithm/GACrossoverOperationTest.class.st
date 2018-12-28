Class {
	#name : #GACrossoverOperationTest,
	#superclass : #TestCase,
	#instVars : [
		'i1',
		'i2',
		'op'
	],
	#category : #'GeneticAlgorithm-Tests'
}

{ #category : #running }
GACrossoverOperationTest >> setUp [
    super setUp.
    i1 := GAIndividual new genes: 'abcd'.
    i2 := GAIndividual new genes: 'defg'.
    op := GACrossoverOperation new.
]

{ #category : #running }
GACrossoverOperationTest >> testCrossover1 [
    | i3 |  
    i3 := op crossover: i1 with: i2 midpoint: 2.
    self assert: i3 genes equals: 'abfg'
]

{ #category : #running }
GACrossoverOperationTest >> testCrossover2 [
    | i3 |
    i3 := op crossover: i1 with: i2 midpoint: 1.
    self assert: i3 genes equals: 'aefg'
]

{ #category : #running }
GACrossoverOperationTest >> testCrossover3 [
    | i3 |
    i3 := op crossover: i1 with: i2 midpoint: 0.
    self assert: i3 genes equals: 'defg'
]

{ #category : #running }
GACrossoverOperationTest >> testCrossover4 [
    | i3 |
    op random: (Random seed: 42).
    i3 := op crossover: i1 with: i2.
    self assert: i3 genes equals: 'aefg'
]
