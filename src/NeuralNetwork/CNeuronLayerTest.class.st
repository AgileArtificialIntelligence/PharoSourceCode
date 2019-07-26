"
This Test Class is for test the behavior of a Convolutional Neural class.

This class will contain unit test for basic convolution.

@yvanGuemkam 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #CNeuronLayerTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
CNeuronLayerTest >> testBasicConvolution [
	"To test if a simple convolution work well."

	| cl cube f1 f2 outputs |
	cl := CNeuronLayer new initializeForNbOfFeatures: 2 withWidth: 3 height: 3 depth: 3 andOutputSize: 3.
	cl stride: 2.
	f1 := Feature new.
	f1 characteristics: #(
									#(#(-1 1 0) #(1 0 -1) #(0 -1 0))
									#(#(1 -1 1) #(-1 -1 1) #(-1 0 -1))
									#(#(0 1 0) #(-1 1 0) #(0 0 0))
	); bias: 1.
	f2 := Feature new.
	f2 characteristics: #(
									#(#(0 1 -1) #(0 1 1) #(-1 0 1))
									#(#(1 0 -1) #(0 -1 1) #(1 0 1))
									#(#(-1 -1 1) #(0 -1 -1) #(1 0 1))
	); bias: 0.
	cl features: { f1 . f2 }.
	cube := #(
			#(#(2 1 2) #(0 1 2) #(1 1 2) #(2 2 0) #(0 2 1))
			#(#(0 1 2) #(2 1 1) #(2 1 0) #(1 2 0) #(0 2 2))
			#(#(2 1 1) #(0 0 1) #(0 2 2) #(0 1 1) #(1 0 0))
			#(#(1 2 0) #(1 1 1) #(1 1 1) #(1 0 2) #(1 1 2))
			#(#(1 0 1) #(2 0 0) #(1 0 2) #(1 0 0) #(2 2 0))).
	cl feed: cube.
	outputs := cl neurons collect: [ :row | row collect: [ :col | col collect: [ :neuron | neuron output ]]].
	
	self assert: (outputs size) equals: 3.
	self assert: (outputs anyOne size) equals: 3.
	self assert: (outputs anyOne anyOne size) equals: 2.
	
	self assert: (((outputs at: 1) at: 1) at: 1) equals: -0.7615941559557646. "tanh -1"
	self assert: (((outputs at: 1) at: 1) at: 2) equals: 0.9950547536867305. 	"tanh 3"
	self assert: (((outputs at: 1) at: 2) at: 1) equals: 0. 						"tanh 0"
	self assert: (((outputs at: 1) at: 2) at: 2) equals: -0.7615941559557646. "tanh -1"
	self assert: (((outputs at: 1) at: 3) at: 1) equals: 0.999329299739067. 	"tanh 4"
	self assert: (((outputs at: 1) at: 3) at: 2) equals: -0.9999877116507956. "tanh -6"
	
	self assert: (((outputs at: 2) at: 1) at: 1) equals: -0.9993292997390673. "tanh -4"
	self assert: (((outputs at: 2) at: 1) at: 2) equals: 0.9950547536867305. "tanh 3"
	self assert: (((outputs at: 2) at: 2) at: 1) equals: 0.7615941559557649. "tanh 1"
	self assert: (((outputs at: 2) at: 2) at: 2) equals: 0. 						"tanh 0"
	self assert: (((outputs at: 2) at: 3) at: 1) equals: -0.7615941559557646. "tanh -1"
	self assert: (((outputs at: 2) at: 3) at: 2) equals: 0.9950547536867305. "tanh 3"
	
	self assert: (((outputs at: 3) at: 1) at: 1) equals: -0.7615941559557646. "tanh -1"
	self assert: (((outputs at: 3) at: 1) at: 2) equals: 0.9999092042625951. "tanh 5"
	self assert: (((outputs at: 3) at: 2) at: 1) equals: 0.9950547536867305. "tanh 3"
	self assert: (((outputs at: 3) at: 2) at: 2) equals: 0.9999997749296758. "tanh 8"
	self assert: (((outputs at: 3) at: 3) at: 1) equals: -0.9993292997390673. "tanh -4"
	self assert: (((outputs at: 3) at: 3) at: 2) equals: 0. 						"tanh 0"
]
