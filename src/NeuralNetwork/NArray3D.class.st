"
This class is for represent data types used in Convolutionnal layers, in particular 3D arrays.

This class will allow to represent Receptive Fields, Features and so on.

No collaborators in this class. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	cuboid:		<Object>


    Implementation Points
"
Class {
	#name : #NArray3D,
	#superclass : #Object,
	#instVars : [
		'cuboid'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
NArray3D class >> initializeWithValue: aCuboid [
	"To create a 3D array with a provided value."

	^ self new values: aCuboid; yourself.
]

{ #category : #removing }
NArray3D >> createSubCuboidOfWidth: widthAsNumber beginAtRow: row column: column [
	"To create a subcuboid beginning at row row and column column."

	| width height |
	width := cuboid size.
	height := cuboid anyOne size.
	
	1 to: width do: [ :index |
		(index < row or: (row + widthAsNumber < index)) ifTrue: [ self removeRow: index ] ].
	cuboid := cuboid reject: #isNil.
	1 to: height do: [ :index |
		(index < column or: (column + widthAsNumber < index)) ifTrue: [ self removeColumn: index ] ].
	cuboid := cuboid collect: [ :elmt | elmt reject: #isNil ].
]

{ #category : #initialization }
NArray3D >> depthSize [
	"To get the value of depth of the cuboid."

	cuboid anyOne anyOne size
]

{ #category : #'as yet unclassified' }
NArray3D >> getElementAtRow: i column: j depth: k [
	"To get one element in the cuboid by coordinates."

	^ ((cuboid at: i) at: j) at: k.
]

{ #category : #initialization }
NArray3D >> initializeWidth: width height: height depth: depth [
	"To configure the 3D array with width, height and depth."

	cuboid := (1 to: width) collect: [ :notUsed1 |
		(1 to: height) collect: [ :notUsed2 | Array new: depth ] ]
]

{ #category : #'as yet unclassified' }
NArray3D >> mult: anArray3D [
	"To directly multiply 3D array. We will multiply the values in the same indexes and return a 3D array."

	| anArray |
	anArray := self values collectWithIndex: [ :elmtX :indexI |
		elmtX collectWithIndex: [ :elmtY :indexJ |
			elmtY collectWithIndex: [ :elmtZ :indexK |
				elmtZ * (anArray3D getElementAtRow: indexI column: indexJ depth: indexK) ] ] ].
	self values: anArray.
]

{ #category : #initialization }
NArray3D >> numberOfColumns [
	"To get the number of column of the cuboid."

	cuboid anyOne size
]

{ #category : #initialization }
NArray3D >> numberOfRows [
	"To get the number of row of the cuboid."

	cuboid size
]

{ #category : #removing }
NArray3D >> removeColumn: columnIndex [
	"To remove a specific column in the cuboid. The index of column to remove is columnIndex."

	cuboid do: [ :elmt | elmt at: columnIndex put: nil ].
]

{ #category : #removing }
NArray3D >> removeRow: rowIndex [
	"To remove a specific row in the cuboid. The index of row to remove is rowIndex."

	cuboid at: rowIndex put: nil.
]

{ #category : #initialization }
NArray3D >> setElementAtRow: i column: j depth: k withValue: aNumber [
	"To set the value at the position (i, j, k) in the cuboid with aNumber value ."

	((cuboid at: i) at: j) at: k put: aNumber
]

{ #category : #'as yet unclassified' }
NArray3D >> sum [
	"Compute the sum of all values in the 2D array corresponding to a projection of a specific z on plane (x y), and sum these values."

	| depth xyTab resTab |
	depth := self values anyOne anyOne size.
	resTab := (1 to: depth) collect: [ :index |
		xyTab := self values flatCollect: [ :row | row collect: [ :tab | tab at: index ] ].
		xyTab sum ].
	^ resTab sum
]

{ #category : #accessing }
NArray3D >> values [
	"To return values stored in the 3D array."

	^ cuboid
]

{ #category : #accessing }
NArray3D >> values: aCuboid [
	"To set values stored in the 3D array."

	cuboid := aCuboid
]
