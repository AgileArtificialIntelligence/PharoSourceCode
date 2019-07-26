"
This is a utility class to manage data as volumes.

This class is implemented as an 3D Array with basic operations like sum and others.

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
	#name : #NArray3DTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
NArray3DTest >> testBasic [
	"This test is for check correct initialization."

	| cuboid anArray |
	cuboid := #(
					#(#(0 0 0) #(0 0 0) #(0 0 0))
					#(#(0 0 0) #(0 1 2) #(2 0 1))
					#(#(0 0 0) #(0 2 2) #(0 1 1))).				
	anArray := NArray3D initializeWithValue: cuboid.
	
	self assert: (anArray getElementAtRow: 1 column: 1 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 1 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 1 depth: 3) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 2 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 2 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 2 depth: 3) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 3 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 3 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 1 column: 3 depth: 3) equals: 0.
	
	self assert: (anArray getElementAtRow: 2 column: 1 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 2 column: 1 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 2 column: 1 depth: 3) equals: 0.
	self assert: (anArray getElementAtRow: 2 column: 2 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 2 column: 2 depth: 2) equals: 1.
	self assert: (anArray getElementAtRow: 2 column: 2 depth: 3) equals: 2.
	self assert: (anArray getElementAtRow: 2 column: 3 depth: 1) equals: 2.
	self assert: (anArray getElementAtRow: 2 column: 3 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 2 column: 3 depth: 3) equals: 1.
	
	self assert: (anArray getElementAtRow: 3 column: 1 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 3 column: 1 depth: 2) equals: 0.
	self assert: (anArray getElementAtRow: 3 column: 1 depth: 3) equals: 0.
	self assert: (anArray getElementAtRow: 3 column: 2 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 3 column: 2 depth: 2) equals: 2.
	self assert: (anArray getElementAtRow: 3 column: 2 depth: 3) equals: 2.
	self assert: (anArray getElementAtRow: 3 column: 3 depth: 1) equals: 0.
	self assert: (anArray getElementAtRow: 3 column: 3 depth: 2) equals: 1.
	self assert: (anArray getElementAtRow: 3 column: 3 depth: 3) equals: 1.
]

{ #category : #tests }
NArray3DTest >> testMult [
	"To test if the message mult preduced expected result."

	| cuboid1 cuboid2 arr |
	cuboid1 := #(
					#(#(0 0 0) #(0 0 0) #(0 0 0))
					#(#(0 0 0) #(0 1 2) #(2 0 1))
					#(#(0 0 0) #(0 2 2) #(0 1 1))).
	cuboid2 := #(
					#(#(1 0 -1) #(0 1 1) #(-1 0 1))
					#(#(1 -1 1) #(1 1 0) #(0 -1 1))
					#(#(-1 1 0) #(0 -1 1) #(-1 -1 -1))).
	arr := (NArray3D initializeWithValue: cuboid1) mult: (NArray3D initializeWithValue: cuboid2).
	
	self assert: (arr getElementAtRow: 1 column: 1 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 2 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 3 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 1 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 2 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 3 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 1 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 2 depth: 1) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 3 depth: 1) equals: 0.
	
	self assert: (arr getElementAtRow: 1 column: 1 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 2 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 3 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 1 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 2 depth: 2) equals: 1.
	self assert: (arr getElementAtRow: 2 column: 3 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 1 depth: 2) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 2 depth: 2) equals: -2.
	self assert: (arr getElementAtRow: 3 column: 3 depth: 2) equals: -1.
	
	self assert: (arr getElementAtRow: 1 column: 1 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 2 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 1 column: 3 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 1 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 2 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 2 column: 3 depth: 3) equals: 1.
	self assert: (arr getElementAtRow: 3 column: 1 depth: 3) equals: 0.
	self assert: (arr getElementAtRow: 3 column: 2 depth: 3) equals: 2.
	self assert: (arr getElementAtRow: 3 column: 3 depth: 3) equals: -1.
]

{ #category : #tests }
NArray3DTest >> testSum [
	"To test if the sum message return a correct value."

	| cuboid arr |
	cuboid := #(
					#(#(0 0 0) #(0 0 0) #(0 0 0))
					#(#(0 0 0) #(-2 -1 2) #(0 0 -2))
					#(#(0 0 0) #(0 1 0) #(0 0 0))).				
	arr := NArray3D initializeWithValue: cuboid.
	
	self assert: (arr sum) equals: -2.
]
