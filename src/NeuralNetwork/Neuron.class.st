Class {
	#name : #Neuron,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'learningRate',
		'activationFunction',
		'delta',
		'output'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #'as yet unclassified' }
Neuron >> adjustBias [
    bias := bias + (learningRate * delta)
]

{ #category : #'as yet unclassified' }
Neuron >> adjustDeltaWith: anError [
    delta := anError * (activationFunction derivative: output)
]

{ #category : #'as yet unclassified' }
Neuron >> adjustWeightWithInput: inputs [
    inputs withIndexDo: [ :anInput :index | 
        weights at: index put: ((weights at: index) + (learningRate * delta * anInput)) ]
]

{ #category : #accessing }
Neuron >> bias [
    ^ bias
]

{ #category : #accessing }
Neuron >> bias: aNumber [
    bias := aNumber
]

{ #category : #accessing }
Neuron >> delta [
    "Return the delta value computed when propagating the error"
    ^ delta
]

{ #category : #accessing }
Neuron >> feed: inputs [
    | z |
    z := (inputs with: weights collect: [ :x :w | x * w ]) sum + bias.
    output := activationFunction eval: z.
    ^ output   
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

{ #category : #accessing }
Neuron >> output [
    "Return the output value, previous computed when doing a feed:"
    ^ output
]

{ #category : #'as yet unclassified' }
Neuron >> sigmoid [
    activationFunction := SigmoidAF new
]

{ #category : #'as yet unclassified' }
Neuron >> step [
    activationFunction := StepAF new
]

{ #category : #'as yet unclassified' }
Neuron >> tanh [
	"To specify that the activation function is the hyperbolic tangent function"

	activationFunction := HyperbolicTangentAF new
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
