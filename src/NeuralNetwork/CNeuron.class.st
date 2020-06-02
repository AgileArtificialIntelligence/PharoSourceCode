Class {
	#name : #CNeuron,
	#superclass : #Neuron,
	#category : #'NeuralNetwork-Core'
}

{ #category : #initialization }
CNeuron >> feedConvolutional: inputs withBias: aBias [
	"To apply a volume as input and obtain the output of the neuron."

	| z |
	z := (NArray3D initializeWithValue: inputs) mult: (NArray3D initializeWithValue: (self weights)).
	output := activationFunction eval: (aBias + z sum).
	^ output
]
