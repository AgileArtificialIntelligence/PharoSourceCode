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
	m length1: 10.
	m length2: 50.
	m time1: 4.
	m time2: 10.
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
	values := creature materialize: #(10 60 2.1286719139333217 5 12).
	self assert: values muscles first length1 equals: 10.
	self assert: values muscles first length2 equals: 60.
	self assert: values muscles first strenght equals: 2.1286719139333217.
	self assert: values muscles first time1 equals: 5.
	self assert: values muscles first time2 equals: 12.
]

{ #category : #tests }
CCreatureTest >> testSerialization [
	| values |
	values := creature serialize.
	self assert: values size equals: (creature muscles size * 5).
	self assert: values equals: #(10 50 1.7899166223546101 4 10)
	"self assert: values equals: #(10 50 2.1286719139333217 4 10)"
]

{ #category : #tests }
CCreatureTest >> testSerializationWithBones [
	| values |
	creature addBoneFromIndex: 1 toIndex: 2.
	values := creature serialize.
	self assert: values size equals: (creature muscles size * 5).
	self assert: values equals: #(10 50 1.7899166223546101 4 10)
	"self assert: values equals: #(10 50 2.1286719139333217 4 10)"
]

{ #category : #tests }
CCreatureTest >> testWithBones [

	creature := CCreature new configureNodes: 3.
	creature addBoneFromIndex: 1 toIndex: 2 length: 50.
	creature addBoneFromIndex: 1 toIndex: 3.
	self assert: creature bones size equals: 2.
	
	
]
