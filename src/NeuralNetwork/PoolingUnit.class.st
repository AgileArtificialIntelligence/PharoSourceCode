"
This class is like a neuron which has inputs on a specific receptive fields.

This class is responsible for pooling operation.

@yvanGuemkam. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	indexArray:		<Object>
	inputVolume:		<Object>
	mode:		<Object>
	outputArray:		<Object>


    Implementation Points
"
Class {
	#name : #PoolingUnit,
	#superclass : #Object,
	#instVars : [
		'outputArray',
		'indexesArray',
		'mode'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
PoolingUnit >> feed: inputs [
	"To run the pooling on an input."

	self subclassResponsibility 
]

{ #category : #accessing }
PoolingUnit >> indexesArray [
	"To get indexesArray attribute of the unit."

	^ indexesArray
]

{ #category : #initialization }
PoolingUnit >> initialize [
	"To custom initialization."

	super initialize
]

{ #category : #accessing }
PoolingUnit >> outputArray [
	"To get outputArray attribute of the unit."

	^ outputArray
]
