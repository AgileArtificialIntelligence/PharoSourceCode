"
This class represent the features learned by the network.

This features will be update by the back propagation algorithm.

@yvanGuemkam. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	biases:		<Object>
	characteristics:		<Object>
	depth:		<Object>


    Implementation Points
"
Class {
	#name : #Feature,
	#superclass : #Object,
	#instVars : [
		'characteristics',
		'bias',
		'depth'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #accessing }
Feature >> bias [
	"To get bias attribute of the feature."

	^ bias.
]

{ #category : #accessing }
Feature >> bias: aNumber [
	"To set bias attribute of the feature."

	bias := aNumber.
]

{ #category : #accessing }
Feature >> characteristics [
	"To get characteristics attribute of the feature."

	^ characteristics.
]

{ #category : #accessing }
Feature >> characteristics: aVolumeOfCharacteristics [
	"To set characteristics attribute of the feature."

	characteristics := aVolumeOfCharacteristics.
]

{ #category : #accessing }
Feature >> depth [
	"To get depth attribute which indicates the index of the feature."

	^ depth.
]

{ #category : #accessing }
Feature >> depth: anInteger [
	"To set depth attribute which indicates the index of the feature."

	depth := anInteger.
]

{ #category : #initialization }
Feature >> initializeWidth: width height: height depth: dept [
	"To create a feature with width, height and depth."

	| r |
	r := Random new seed: 42.
	bias := (r next) * 2 - 1.
	characteristics := (1 to: width) collect: [ :notUsed1 |
		(1 to: height) collect: [ :notUsed2 | (r next: dept) * 2 - 1 ] ].
]
