Class {
	#name : #FlattenLayerTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
FlattenLayerTest >> testBackwardReconstruct [
	"To test the backward reconstruction of the input volume."

	| cube fl input |
	cube := #(
		#(#(1 2 0) #(1 1 1) #(1 1 1))
		#(#(1 0 1) #(2 0 0) #(1 0 2))
		#(#(1 0 2) #(1 0 0) #(1 0 1))).
	fl := FlattenLayer new.
	fl feed: cube.
	input := fl backwardReconstruct: #(1 2 0 1 1 1 1 1 1 1 0 1 2 0 0 1 0 2 1 0 2 1 0 0 1 0 1).
	
	self assert: input equals: cube.
]

{ #category : #tests }
FlattenLayerTest >> testFeed [
	"To verify the forward pass into the FlattenLayer."

	| fl cube |
	cube := #(
		#(#(1 2 0) #(1 1 1) #(1 1 1))
		#(#(1 0 1) #(2 0 0) #(1 0 2))
		#(#(1 0 2) #(1 0 0) #(1 0 1))).
	fl := FlattenLayer new.
	fl feed: cube.
	
	self assert: (fl outputs size) equals: 27.
	self assert: (fl outputs at: 1) equals: 1.
	self assert: (fl outputs at: 2) equals: 2.
	self assert: (fl outputs at: 3) equals: 0.
	self assert: (fl outputs at: 4) equals: 1.
	self assert: (fl outputs at: 5) equals: 1.
	self assert: (fl outputs at: 6) equals: 1.
	self assert: (fl outputs at: 7) equals: 1.
	self assert: (fl outputs at: 8) equals: 1.
	self assert: (fl outputs at: 9) equals: 1.
	
	self assert: (fl outputs at: 10) equals: 1.
	self assert: (fl outputs at: 11) equals: 0.
	self assert: (fl outputs at: 12) equals: 1.
	self assert: (fl outputs at: 13) equals: 2.
	self assert: (fl outputs at: 14) equals: 0.
	self assert: (fl outputs at: 15) equals: 0.
	self assert: (fl outputs at: 16) equals: 1.
	self assert: (fl outputs at: 17) equals: 0.
	self assert: (fl outputs at: 18) equals: 2.
	
	self assert: (fl outputs at: 19) equals: 1.
	self assert: (fl outputs at: 20) equals: 0.
	self assert: (fl outputs at: 21) equals: 2.
	self assert: (fl outputs at: 22) equals: 1.
	self assert: (fl outputs at: 23) equals: 0.
	self assert: (fl outputs at: 24) equals: 0.
	self assert: (fl outputs at: 25) equals: 1.
	self assert: (fl outputs at: 26) equals: 0.
	self assert: (fl outputs at: 27) equals: 1.
]
