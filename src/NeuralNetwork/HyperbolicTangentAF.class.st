"
This class is for use tanh activation fonction on CNN.

This class allow to calculate output and derivative for neurons with tanh activation function.

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
	#name : #HyperbolicTangentAF,
	#superclass : #ActivationFunction,
	#category : #'NeuralNetwork-Core'
}

{ #category : #'as yet unclassified' }
HyperbolicTangentAF >> derivative: output [
	"To transfert derivative error for the backpropagation algorithm"

	^ 1 + (output raisedTo: 2)
]

{ #category : #'as yet unclassified' }
HyperbolicTangentAF >> eval: z [
	"To evaluate activation function on sum of bias and scalar product of weights and inputs vectors"

	^ 1 - (2 / (1 + (2 * z) exp))
]
