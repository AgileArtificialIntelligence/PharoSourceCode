Class {
	#name : #GAOrderedCrossoverOperation,
	#superclass : #GAAbstractCrossoverOperation,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
GAOrderedCrossoverOperation >> crossover: partnerA with: partnerB [
    "Return a new child, which is the result of mixing myself with the argument"

 	| i1 i2 |
	i1 := self pickCutPointFor: partnerA.
	i2 := self pickCutPointFor: partnerA.
	
	(i1 > i2) ifTrue: [ | t | t := i1. i1 := i2. i2 := t ].
	^ self crossover: partnerA with: partnerB from: i1 to: i2
]

{ #category : #'as yet unclassified' }
GAOrderedCrossoverOperation >> crossover: partnerA with: partnerB from: i1 to: i2 [
    "Return a new child, which is the result of mixing myself with the argument"

    | child crossOverGenes runningIndex swath |
    child := GAIndividual new.
    child random: random.

	swath := partnerA genes copyFrom: i1 to: i2.
	crossOverGenes := Array new: partnerA genes size.
	crossOverGenes := crossOverGenes copyReplaceFrom: i1 to: i2 with: swath.

	runningIndex := 1.
	"((partnerB genes copyFrom: 1 to: i1), (partnerB genes copyFrom: i2 to: partnerB genes size)) "
	(partnerB genes copyWithoutAll: swath)
		do: [ :v | (crossOverGenes includes: v) ifFalse: [ 
				[(crossOverGenes at: runningIndex) notNil] whileTrue: [ runningIndex := runningIndex + 1 ]. 
				crossOverGenes at: runningIndex put: v ] ].

    child genes: crossOverGenes.
    ^ child
]

{ #category : #'as yet unclassified' }
GAOrderedCrossoverOperation >> pickCutPointFor: partnerA [
    "Simply return a random number between 1 and the number of genes of the individual provided as argument"
    ^ random nextInt: partnerA genes size
]
