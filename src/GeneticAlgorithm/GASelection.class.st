Class {
	#name : #GASelection,
	#superclass : #Object,
	#instVars : [
		'population',
		'fittest',
		'initialPopulation',
		'fitnessBlock',
		'populationSize',
		'compareFitness',
		'engine'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #accessing }
GASelection >> checkIfEngineSet [
    self assert: [ engine notNil ] description: 'Should set the engine'.
]

{ #category : #accessing }
GASelection >> checkIfInitialPopulationSet [
    self assert: [ initialPopulation notNil ] description: 'Should set the initial population'.
    self assert: [ initialPopulation isCollection ] description: 'Has to be a collection'.
    self assert: [ initialPopulation notEmpty ] description: 'Cannot be empty'
]

{ #category : #accessing }
GASelection >> compareFitness: aTwoArgBlock [
    "Take as argument a two argument block that compare the fitness of two individuals"
    compareFitness := aTwoArgBlock
]

{ #category : #accessing }
GASelection >> createNewPopulation [
    "Create a new population"
    self subclassResponsibility 
]

{ #category : #accessing }
GASelection >> crossover: partnerA with: partnerB [
    "Return one child"
    ^ engine crossover: partnerA with: partnerB
]

{ #category : #accessing }
GASelection >> doSelection [
    self checkIfEngineSet.
    self checkIfInitialPopulationSet.
    populationSize := initialPopulation size.
    fittest := initialPopulation first.
    initialPopulation
        do: [ :ind | 
            ind computeFitnessUsing: fitnessBlock.
            (self isIndividual: ind betterThan: fittest)
                ifTrue: [ fittest := ind ] ].
    self createNewPopulation.

    initialPopulation := population.
]

{ #category : #accessing }
GASelection >> engine [
    "Return the GAEngine to which I am associated to"
    ^ engine
]

{ #category : #accessing }
GASelection >> engine: theEngine [
    "Set the GAEntine to which I have to be associated with"
    engine := theEngine.
    self checkIfEngineSet
]

{ #category : #accessing }
GASelection >> fitnessBlock [
    ^ fitnessBlock
]

{ #category : #accessing }
GASelection >> fitnessBlock: aOneArgBlock [
    "The argument is evaluated on the genes of each individual.
    The block argument has to compute the fitness."
    fitnessBlock := aOneArgBlock
]

{ #category : #accessing }
GASelection >> fittest [
    "Return the fittest individual from the new population"
    ^ fittest
]

{ #category : #accessing }
GASelection >> initialPopulation: aPopulationAsIndividuals [
    "Set the initial population. This is used to create the new population"
    initialPopulation := aPopulationAsIndividuals.
    self checkIfInitialPopulationSet
]

{ #category : #initialization }
GASelection >> initialize [
    super initialize.
    population := OrderedCollection new.
]

{ #category : #accessing }
GASelection >> isIndividual: ind betterThan: fittestIndividual [
    ^ engine isIndividual: ind betterThan: fittestIndividual
]

{ #category : #accessing }
GASelection >> mutate: child [
    ^ engine mutate: child
]

{ #category : #accessing }
GASelection >> population [
    "Return the new population"
    ^ population
]

{ #category : #accessing }
GASelection >> populationSize [
    "Return the population size"
    ^ initialPopulation size
]

{ #category : #accessing }
GASelection >> populationSize: anInteger [
    "Set the population size"
    populationSize := anInteger
]

{ #category : #accessing }
GASelection >> randomNumber: value [
    "Return a number between 1 and value"
    ^ engine randomNumber: value
]
