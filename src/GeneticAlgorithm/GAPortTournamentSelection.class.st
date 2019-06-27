Class {
	#name : #GAPortTournamentSelection,
	#superclass : #GATournamentSelection,
	#instVars : [
		'port'
	],
	#category : #'GeneticAlgorithm-Port'
}

{ #category : #accessing }
GAPortTournamentSelection >> createNewPopulation [
    "Return a new population made of newly breed individual"
    
| distributed mapped time distrTime mapTime collTime |
	time := DateAndTime now.
	distributed := port distribute: (1 to: self populationSize).
	distrTime := (DateAndTime now - time).
	mapped := distributed map: [ :seed |
		| partnerA partnerB child |
		engine random: (Random seed: seed).
		partnerA := self getGoodIndividual.
      partnerB := self getGoodIndividual.
      child := self mutate: (self crossover: partnerA with: partnerB).
      child computeFitnessUsing: engine fitnessBlock.
		child.
	].
	mapTime :=  (DateAndTime now - time) - distrTime.
	population := mapped getCollection.
	collTime := (DateAndTime now - time) - distrTime - mapTime.
	Transcript crShow: distrTime asString , ' ; ' , mapTime asString , ' ; ' , collTime asString
]

{ #category : #accessing }
GAPortTournamentSelection >> doSelection [
	"^ super doSelection"
	| initD mapped |
	self halt.
	self checkIfEngineSet.
	self checkIfInitialPopulationSet.
	populationSize := initialPopulation size.
	fittest := initialPopulation first.
	fittest computeFitnessUsing: fitnessBlock.
	initD := port distribute: initialPopulation.
	mapped := (initD map: [ :ind | ind computeFitnessUsing: fitnessBlock. ]) execute.
	initialPopulation := mapped getCollection.
	fittest := mapped
		aggregate: [ :fit :individual | 
			(self isIndividual: individual betterThan: fit)
				ifTrue: [individual]
				ifFalse: [fit] ]
		withBlock: [ :best1 :best2 | 
			(self isIndividual: best1 betterThan: best2)
				ifTrue: [ best1 ]
				ifFalse: [ best2 ] ]
		inject: fittest.
	self createNewPopulation.
	initialPopulation := population
]

{ #category : #accessing }
GAPortTournamentSelection >> port [
	^ port
]

{ #category : #accessing }
GAPortTournamentSelection >> port: anObject [
	port := anObject
]
