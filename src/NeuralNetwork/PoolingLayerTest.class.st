"
This class is for unit test the PoolingLayer class.

This class will implement tests on message feed:, and others.

@yvanGuemkam. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #PoolingLayerTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
PoolingLayerTest >> testFeed [
	"To test if a PoolingLayer on a single depth slice works well."

	| cuboid pl output |
	cuboid := #(
					#(#(1) #(1) #(2) #(4))
					#(#(5) #(6) #(7) #(8))
					#(#(3) #(2) #(1) #(0))
					#(#(1) #(2) #(3) #(4))
	).
	pl := PoolingLayer new.
	pl initializeForReceptiveFieldSize: 2 withStride: 2.
	pl feed: cuboid.
	output := pl units collect: [ :row | row collect: #outputArray ].
												
	self assert: (output size) equals: 2.
	self assert: (output anyOne size) equals: 2.
	self assert: (output anyOne anyOne size) equals: 1.
	
	self assert: (((output at: 1) at: 1) at: 1) equals: 6.
	self assert: (((output at: 1) at: 2) at: 1) equals: 8.
	self assert: (((output at: 2) at: 1) at: 1) equals: 3.
	self assert: (((output at: 2) at: 2) at: 1) equals: 4.
]
