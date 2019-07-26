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

{ #category : #accessing }
PoolingUnit >> avgFeed: inputs [
	"To do avg pooling on a receptive field. This function will output the mean of values in a receptive field."

	self shouldBeImplemented.
]

{ #category : #initialization }
PoolingUnit >> feed: inputs [
	"To run the pooling on an input."

	mode = 'MAX' ifTrue: [ self maxFeed: inputs ]
					ifFalse: [ self avgFeed: inputs ]
]

{ #category : #accessing }
PoolingUnit >> indexesArray [
	"To get indexesArray attribute of the unit."

	^ indexesArray
]

{ #category : #initialization }
PoolingUnit >> initialize [
	"To custom initialization."

	super initialize.
	mode := 'MAX'.
]

{ #category : #accessing }
PoolingUnit >> maxFeed: inputs [
	"To do max pooling on a receptive field. This function will output the max of a receptive field."

	| inputDepth rowMaxArray columnIndexOfMax rowIndexMax |
	inputDepth := inputs anyOne anyOne size.
	indexesArray := Array new: inputDepth.
	outputArray := (1 to: inputDepth) collect: [ :index |
		| anArray maxValue |
		anArray := inputs collect: [ :row | row collect: [ :col | col at: index ]].
		rowMaxArray := anArray collect: [ :e | e max ].
		maxValue := rowMaxArray max.
		rowIndexMax := rowMaxArray indexOf: maxValue.
		columnIndexOfMax := (anArray at: rowIndexMax) indexOf: maxValue.
		indexesArray at: index put: { rowIndexMax . columnIndexOfMax }.
		maxValue ].
	^ outputArray
]

{ #category : #accessing }
PoolingUnit >> mode [
	"To get mode attribute of the unit."

	^ mode
]

{ #category : #accessing }
PoolingUnit >> mode: aString [
	"To set mode attribute of the unit. The mode should be MAX or AVG."

	mode := aString
]

{ #category : #accessing }
PoolingUnit >> outputArray [
	"To get outputArray attribute of the unit."

	^ outputArray
]
