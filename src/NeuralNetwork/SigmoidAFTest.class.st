"
A SigmoidAFTest is a test class for testing the behavior of SigmoidAF
"
Class {
	#name : #SigmoidAFTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
SigmoidAFTest >> testSigmoidAFConvergeToOneForPositiveValues [


| f |
f := SigmoidAF new.
self assert: (f eval: 10000) closeTo: 1
]

{ #category : #tests }
SigmoidAFTest >> testSigmoidAFConvergeToZeroForNegativeValues [
	| f |
	f := SigmoidAF new.
	self assert: (f eval: -10000) closeTo: 0
]

{ #category : #tests }
SigmoidAFTest >> testSigmoidAFOnZeroReturnsZeroDotFive [

|f|
f := SigmoidAF new.
self assert: (f eval:0) equals: 0.5
]
