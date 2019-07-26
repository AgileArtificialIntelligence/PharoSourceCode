"
This class allow to test a convolution unit.

This class will allow to feed a volume as input and weights of neuron.

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
	#name : #CNeuronTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
CNeuronTest >> testFeed [
	"Test the output of a convolutional neuron for specific input and bias."

	| c inputs |
	c := Neuron new.
	c bias: 0; tanh;
		weights: #(
						#(#(-1 1 0) #(1 0 -1) #(0 -1 0))
						#(#(1 -1 1) #(-1 -1 1) #(-1 0 -1))
						#(#(0 1 0) #(-1 1 0) #(0 0 0))
	).	
	inputs := #(
					#(#(0 0 0) #(0 0 0) #(0 0 0))
					#(#(0 0 0) #(2 1 2) #(0 1 2))
					#(#(0 0 0) #(0 1 2) #(2 1 1))
	).
	
	self assert: (c feedConvolutional: inputs withBias: 1) equals: -0.7615941559557646. "tanh -1"
]
