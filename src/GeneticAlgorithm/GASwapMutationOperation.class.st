Class {
	#name : #GASwapMutationOperation,
	#superclass : #GAAbstractMutationOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GASwapMutationOperation >> doMutate: individual [
	"Mutate genes of the argument"

	| i2 tmp |
	self checkForRandomNumber.
	1 to: individual genes size do: [ :i1 | 
		self randomNumber <= mutationRate
			ifTrue: [ i2 := random nextInt: individual genes size.
				tmp := individual genes at: i1.
				individual genes at: i1 put: (individual genes at: i2).
				individual genes at: i2 put: tmp ] ]
]
