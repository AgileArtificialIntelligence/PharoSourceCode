Class {
	#name : #GALog,
	#superclass : #Object,
	#instVars : [
		'generationNumber',
		'timeToProduceGeneration',
		'fittestIndividual'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GALog >> fitness [
    "Return the best fitness value of a generation I am representing"
    
    ^ fittestIndividual fitness
]

{ #category : #accessing }
GALog >> fittestIndividual [
    "Return the best individual of the generation I represent"
    ^ fittestIndividual
]

{ #category : #accessing }
GALog >> fittestIndividual: anIndividual [
    "Set the best individual of the generation I represent"
    fittestIndividual := anIndividual
]

{ #category : #accessing }
GALog >> generationNumber [
    "Return the generation number I represent"
    ^ generationNumber
]

{ #category : #accessing }
GALog >> generationNumber: generationNumberAsInteger [
    "Set the generation number I represent"
    generationNumber := generationNumberAsInteger
]

{ #category : #accessing }
GALog >> printOn: str [
    "Provide a descent printing of the log"
    super printOn: str.
    str nextPut: $<.
    str nextPutAll: fittestIndividual genes asString.
    str nextPut: $>.
]

{ #category : #accessing }
GALog >> timeToProduceGeneration [
    "Time to produce the generation I represent"
    ^ timeToProduceGeneration
]

{ #category : #accessing }
GALog >> timeToProduceGeneration: anInteger [
    "Set the time to produce the generation I represent"
    timeToProduceGeneration := anInteger
]
