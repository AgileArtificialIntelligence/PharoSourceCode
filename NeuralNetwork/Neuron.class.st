Class {
	#name : #Neuron,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'learningRate',
		'activationFunction'
	],
	#category : #NeuralNetwork
}

{ #category : #accessing }
Neuron >> bias [
    ^ bias
]

{ #category : #accessing }
Neuron >> bias: aNumber [
    bias := aNumber
]

{ #category : #accessing }
Neuron >> feed: inputs [
    | z |
    z := (inputs with: weights collect: [ :x :w | x * w ]) sum + bias.
    ^ activationFunction eval: z
]

{ #category : #initialization }
Neuron >> initialize [
    super initialize.
    learningRate := 0.1.
    self sigmoid
]

{ #category : #accessing }
Neuron >> learningRate [
    "Return the learning rate of the neuron"
    ^ learningRate
]

{ #category : #accessing }
Neuron >> learningRate: aNumber [
    "Set the learning rate of the neuron"
    learningRate := aNumber
]

{ #category : #'as yet unclassified' }
Neuron >> sigmoid [
    activationFunction := SigmoidAF new
]

{ #category : #'as yet unclassified' }
Neuron >> step [
    activationFunction := StepAF new
]

{ #category : #accessing }
Neuron >> train: inputs desiredOutput: desiredOutput [
    | theError output delta |
    output := self feed: inputs.
    theError := desiredOutput - output.
    delta := theError * (activationFunction derivative: output).    

    inputs withIndexDo: [ :anInput :index | 
        weights at: index put: ((weights at: index) + (learningRate * delta * anInput)) ].

    bias := bias + (learningRate * delta)
]

{ #category : #accessing }
Neuron >> weights [
    ^ weights
]

{ #category : #accessing }
Neuron >> weights: someWeightsAsNumbers [
    weights := someWeightsAsNumbers
]
