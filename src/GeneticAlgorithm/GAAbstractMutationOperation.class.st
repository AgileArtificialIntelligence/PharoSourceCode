Class {
	#name : #GAAbstractMutationOperation,
	#superclass : #GAOperation,
	#instVars : [
		'mutationRate'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #initialization }
GAAbstractMutationOperation >> doMutate: individual [
    "To be overridden"
    self subclassResponsibility 
]

{ #category : #initialization }
GAAbstractMutationOperation >> initialize [
    super initialize.
    self mutationRate: 0.01
]

{ #category : #initialization }
GAAbstractMutationOperation >> mutate: individual [
    "Return a new individual (different object than the argument), result of a mutation from the individual provided as argument."
    | newIndividual |
    newIndividual := GAIndividual new.
    newIndividual random: random.
    newIndividual genes: individual genes copy.
    self doMutate: newIndividual.
    ^ newIndividual
]

{ #category : #initialization }
GAAbstractMutationOperation >> mutationRate [
    "Return the used mutation rate. Typically, a small positive number, close to 0.0 and significantly less than 1.0"
    ^ mutationRate
]

{ #category : #initialization }
GAAbstractMutationOperation >> mutationRate: aFloat [
    "Set the mutation rate. Typically, a small positive number, close to 0.0 and significantly less than 1.0"
    mutationRate := aFloat
]
