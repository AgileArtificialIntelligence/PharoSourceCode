Class {
	#name : #CCreatureTest,
	#superclass : #TestCase,
	#instVars : [
		'creature'
	],
	#category : #Creature
}

{ #category : #tests }
CCreatureTest >> setUp [
	| m |
	super setUp.
	creature := CCreature new configureNbNodes: 2 nbMuscles: 1.
	
	m := creature muscles first.
	m contractedLength: 10.
	m extendedLength: 50.
	m contractedTime: 4.
]

{ #category : #tests }
CCreatureTest >> testBasic [

	| m |
	self assert: creature muscles size equals: 1.
	self assert: creature nodes size equals: 2.
	m := creature muscles first.
	
	self assert: m length equals: 10.
	creature beat; beat; beat.
	self assert: m length equals: 10.
	
	creature beat.
	self assert: m length equals: 50.
	
	(m maxTime - 5) timesRepeat: [ creature beat ].
	self assert: m length equals: 50.
	creature beat.
	self assert: m length equals: 10.
]

{ #category : #tests }
CCreatureTest >> testMaterialize [
	| values |
	values := creature materialize: #(15 60 5).
	self assert: values muscles first contractedLength equals: 15.
	self assert: values muscles first extendedLength equals: 60.
	self assert: values muscles first strength equals: 5.
]

{ #category : #tests }
CCreatureTest >> testSerialization [
	| values |
	values := creature serialize.
	self assert: values size equals: (creature muscles size * 3).
	self assert: values equals: #(10 50 3).
]
