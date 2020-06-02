"
This class represent a receptive field.

It is use for local connectivity.

@yvanGuemkam. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	column:		<Object>
	entries:		<Object>
	row:		<Object>


    Implementation Points
"
Class {
	#name : #ReceptiveField,
	#superclass : #Object,
	#instVars : [
		'entries',
		'row',
		'column'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #accessing }
ReceptiveField >> column [
	"To get column attribute value."

	^ column.
]

{ #category : #accessing }
ReceptiveField >> column: anInteger [
	"To set column attribute with anInteger value."

	column := anInteger.
]

{ #category : #accessing }
ReceptiveField >> entries [
	"To get entries attribute value."

	^ entries.
]

{ #category : #accessing }
ReceptiveField >> entries: aCuboid [
	"To set entries attribute with aCuboid value."

	entries := aCuboid.
]

{ #category : #accessing }
ReceptiveField >> row [
	"To get row attribute value."

	^ row.
]

{ #category : #accessing }
ReceptiveField >> row: anInteger [
	"To set row attribute with anInteger value."

	row := anInteger.
]
