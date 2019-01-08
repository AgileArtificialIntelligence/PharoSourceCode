Class {
	#name : #GAMutationOperation,
	#superclass : #GAAbstractMutationOperation,
	#instVars : [
		'geneFactoryBlock'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GAMutationOperation >> checkForGeneFactory [
    self
        assert: [ geneFactoryBlock notNil ]
        description: 'Need to provide a block to create gene'
]

{ #category : #accessing }
GAMutationOperation >> doMutate: individual [
    "Mutate genes of the argument"
	mutationRate = 0 ifTrue: [ ^ self ].
    self checkForRandomNumber.
    self checkForGeneFactory.
    1 to: individual genes size do: [ :index | 
        self randomNumber <= mutationRate
            ifTrue: [ individual genes at: index put: (geneFactoryBlock cull: random cull: index cull: individual) ] ]  
]

{ #category : #accessing }
GAMutationOperation >> geneFactoryBlock [
    "Return the one-arg block used to create a gene"
    ^ geneFactoryBlock
]

{ #category : #accessing }
GAMutationOperation >> geneFactoryBlock: oneArgBlock [
    "The block receive a random number as argument"
    geneFactoryBlock := oneArgBlock
]
