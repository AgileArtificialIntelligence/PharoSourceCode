Class {
	#name : #MaxPoolingUnit,
	#superclass : #PoolingUnit,
	#category : #'NeuralNetwork-Core'
}

{ #category : #accessing }
MaxPoolingUnit >> feed: inputs [
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
