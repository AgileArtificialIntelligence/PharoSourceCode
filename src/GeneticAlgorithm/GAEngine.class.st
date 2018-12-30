Class {
	#name : #GAEngine,
	#superclass : #GAObject,
	#instVars : [
		'beforeCreatingInitialIndividual',
		'fitnessBlock',
		'createGeneBlock',
		'numberOfGenes',
		'populationSize',
		'logs',
		'population',
		'terminationBlock',
		'compareFitness',
		'mutationOperator',
		'crossoverOperator',
		'selection'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GAEngine >> beforeCreatingInitialIndividual [
	^ beforeCreatingInitialIndividual
]

{ #category : #accessing }
GAEngine >> beforeCreatingInitialIndividual: oneArgBlock [
	"The block provided as argument is evaluated _before_ creating each individual of the initial population"
	beforeCreatingInitialIndividual := oneArgBlock
]

{ #category : #accessing }
GAEngine >> beforeRun [
    "Method executed before creating the initial population"
    self checkIfReadyToRun.  
    selection fitnessBlock: fitnessBlock.
    selection populationSize: populationSize 
]

{ #category : #accessing }
GAEngine >> checkIfReadyToRun [
    "Raise an exception if the configuration is not ready to be run"
    self assert: [ fitnessBlock notNil ] description: 'Need to set a fitnessBlock'.
    self assert: [ createGeneBlock notNil ] description: 'Need to set a createGeneBlock'.
    self assert: [ numberOfGenes notNil ] description: 'Need to set how many genes you wish to have, using numberOfGenes:'.
    self assert: [ logs isEmpty ] description: 'Already been run'.
]

{ #category : #accessing }
GAEngine >> createGeneBlock: threeArgBlock [
    "Three arguments must be provided rand, index, and the individual being filled"
    createGeneBlock := threeArgBlock.
    mutationOperator geneFactoryBlock: threeArgBlock
]

{ #category : #accessing }
GAEngine >> crossover: partnerA with: partnerB [
    "Perform a crossover operation between the two arguments"
    ^ crossoverOperator crossover: partnerA with: partnerB
]

{ #category : #accessing }
GAEngine >> crossoverOperator: aCrossoverOperator [
    "Set the crossover operator used in the algorithm"
    crossoverOperator := aCrossoverOperator.
    crossoverOperator random: random
]

{ #category : #accessing }
GAEngine >> endForMaxNumberOfGeneration: nbOfGenerations [
    "End the algorithm after a fixed number of generations"
    terminationBlock := [ logs last generationNumber >= nbOfGenerations ]
]

{ #category : #accessing }
GAEngine >> endIfFitnessIsAbove: aFitnessValueThreshold [
    "End the algorithm if the best fitness value is above a particular threshold"
    terminationBlock := [ logs last fittestIndividual fitness >= aFitnessValueThreshold ]
]

{ #category : #accessing }
GAEngine >> endIfNoImprovementFor: nbOfGenerations [
    "End if no improvement occurred within a given number of generations"
    ^ self endIfNoImprovementFor: nbOfGenerations withinRangeOf: 0
]

{ #category : #accessing }
GAEngine >> endIfNoImprovementFor: nbOfGenerations withinRangeOf: delta [
    "End if no improvement occurred (within a delta value) within a given number of generations"
    terminationBlock := [ 
        (logs last generationNumber >= nbOfGenerations) and: [ 
            | fs |
            fs := (logs last: nbOfGenerations) collect: [ :aLog | aLog fittestIndividual fitness ].
            (fs max - fs min) <= delta
             ] ]
]

{ #category : #accessing }
GAEngine >> fitnessBlock [
    "Return the fitness block used by the engine"
    ^ fitnessBlock
]

{ #category : #accessing }
GAEngine >> fitnessBlock: aOneArgBlock [
    "The argument is evaluated on the genes of each individual.
    The block argument has to compute the fitness. 
    Higher fitness means to be closer to the solution"
    fitnessBlock := aOneArgBlock
]

{ #category : #accessing }
GAEngine >> initialize [
    super initialize.
    logs := OrderedCollection new.
    random := Random seed: 42.
    self endForMaxNumberOfGeneration: 10.
    populationSize := 10.
    self maximizeComparator.
    mutationOperator := GAMutationOperation new.
    mutationOperator mutationRate: 0.01.
    mutationOperator random: random.
    
    crossoverOperator := GACrossoverOperation new.
    crossoverOperator random: random.
    
    self selection: GATournamentSelection new.

	beforeCreatingInitialIndividual := [ :rand | "do nothing" ]
]

{ #category : #accessing }
GAEngine >> initializePopulation [
    self checkForRandomNumber.
    population := OrderedCollection new.
    populationSize
        timesRepeat: [ 
            | ind |
				beforeCreatingInitialIndividual value: random.
            ind := GAIndividual new.
            population
                add:
                    (ind
                        random: random;
                        set: numberOfGenes genesUsing: createGeneBlock) ]
]

{ #category : #accessing }
GAEngine >> isIndividual: anIndividual betterThan: aFittestIndividual [
    "Compare an individual against the fittest individual of the population"
    ^ compareFitness value: anIndividual fitness value: aFittestIndividual fitness
]

{ #category : #accessing }
GAEngine >> logs [
    "Return the logs of the run"
    ^ logs copy
]

{ #category : #accessing }
GAEngine >> maximizeComparator [
    "A better individual is the one with the highest fitness value"
    compareFitness := [ :f1 :f2 | f1 > f2 ]
]

{ #category : #accessing }
GAEngine >> microPause [
    "Useful when you wish to log in the Transcript and see progresses"
    (Delay forMilliseconds: 1) wait.
    World doOneCycleNow.
]

{ #category : #accessing }
GAEngine >> minimizeComparator [
    "A better individual is the one with the lowest fitness value"
    compareFitness := [ :f1 :f2 | f1 < f2 ]
]

{ #category : #accessing }
GAEngine >> mutate: individual [
    "Mutate the child provided as argument"
    ^ mutationOperator mutate: individual
]

{ #category : #accessing }
GAEngine >> mutationOperator: aMutationOperator [
    mutationOperator := aMutationOperator.
    aMutationOperator random: random
]

{ #category : #accessing }
GAEngine >> mutationRate: aFloat [
    "Set the mutation rate used by the engine. The default value is 0.01"
    mutationOperator mutationRate: aFloat.
]

{ #category : #accessing }
GAEngine >> numberOfGenes: anInteger [
    "Set the number of genes each individual will have"
    numberOfGenes := anInteger
]

{ #category : #accessing }
GAEngine >> populationSize: anInteger [
    "Set the population size"
    populationSize := anInteger
]

{ #category : #accessing }
GAEngine >> produceNewPopulation [
    "This method  
        - produces a new population, put in the variable 'population'
        - select the fittest element of the population"
    selection doSelection.
    population := selection population.
]

{ #category : #accessing }
GAEngine >> randomNumber: maxNumber [
    "Return a number between 1 and maxNumber"
    ^ random nextInt: maxNumber
]

{ #category : #accessing }
GAEngine >> result [
    "Return the genes of the fittest individual. This method is expected to be executed after #run has completed"
    ^ self logs last fittestIndividual genes
]

{ #category : #accessing }
GAEngine >> run [
    "Public method -- Run the genetic algorithm"

    | t log |
    self beforeRun.
    self initializePopulation.
    selection initialPopulation: population.
    selection compareFitness: compareFitness.
    UIManager default
        informUserDuring: [ :bar | 
            | gen |
            gen := 0.
            [ self shouldTerminate ]
                whileFalse: [ gen := gen + 1.
                    bar label: gen asString.
                    self microPause.
                    t := Time now asSeconds.
                    self produceNewPopulation.
                    
                    log := GALog new.
                    log generationNumber: gen.
                    log fittestIndividual: selection fittest.
                    log timeToProduceGeneration: Time now asSeconds - t.
                    logs add: log ] ]
]

{ #category : #accessing }
GAEngine >> selection [
    "Return the selection operator"
    ^ selection
]

{ #category : #accessing }
GAEngine >> selection: aSelection [
    "Set the selection method to be used to create a new population"
    selection := aSelection.
    aSelection engine: self.
]

{ #category : #accessing }
GAEngine >> shouldTerminate [
    logs ifEmpty: [ ^ false ].
    ^ terminationBlock value
]
