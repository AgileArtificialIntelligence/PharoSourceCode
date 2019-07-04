"
A StepAFTest is a test class for testing the behavior of StepAF
"
Class {
	#name : #StepAFTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
StepAFTest >> testStepAFDerivativeIsAlwaysOne [
	| f |
	f := StepAF new.
	self assert: (f derivative: 0) equals: 1.
		self assert: (f derivative: 5) equals: 1.
			self assert: (f derivative: 10) equals: 1.
]

{ #category : #tests }
StepAFTest >> testStepAFOnNegativeNumbersReturnsZero [
	| f |
	f := StepAF new.
	self assert: (f eval: -1) equals: 0
]

{ #category : #tests }
StepAFTest >> testStepAFOnZeroReturnsZero [
	| f |
	f := StepAF new.
	self assert: (f eval: 0) equals: 0
]
