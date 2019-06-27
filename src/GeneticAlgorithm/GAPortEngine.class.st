Class {
	#name : #GAPortEngine,
	#superclass : #GAEngine,
	#instVars : [
		'port'
	],
	#category : #'GeneticAlgorithm-Port'
}

{ #category : #accessing }
GAPortEngine >> initialize [
	super initialize.
	self selection: GAPortTournamentSelection new.
]

{ #category : #accessing }
GAPortEngine >> port [
	^ port 
]

{ #category : #accessing }
GAPortEngine >> port: aPort [
	port := aPort.
	selection port: aPort.
]
