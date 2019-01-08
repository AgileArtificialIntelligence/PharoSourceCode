Class {
	#name : #GAConstrainedCrossoverOperation,
	#superclass : #GAAbstractCrossoverOperation,
	#instVars : [
		'possibleCutpoints'
	],
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
GAConstrainedCrossoverOperation >> pickCutPointFor: partnerA [
	"Argument is not used now. Maybe we can improve that"
	self assert: [ possibleCutpoints notNil ] description: 'Need to provide the possible cut points, using #possibleCutpoints:'.
	^ possibleCutpoints at: (random nextInt: possibleCutpoints size)
]

{ #category : #'as yet unclassified' }
GAConstrainedCrossoverOperation >> possibleCutpoints [
	^ possibleCutpoints
]

{ #category : #'as yet unclassified' }
GAConstrainedCrossoverOperation >> possibleCutpoints: indexes [
	possibleCutpoints := indexes
]
