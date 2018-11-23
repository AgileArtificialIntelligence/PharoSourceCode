Class {
	#name : #NeuronLayer,
	#superclass : #Object,
	#instVars : [
		'previousLayer',
		'nextLayer',
		'neurons'
	],
	#category : #NeuralNetwork
}

{ #category : #'as yet unclassified' }
NeuronLayer >> backwardPropagateError [
    "This is a recursive method. The back propagation begins with the output layer (i.e., the last layer)"

    "We are in an hidden layer"
    neurons doWithIndex: [ :neuron :j |
        | theError |
        theError := 0.0.
        self nextLayer neurons do: [ :nextNeuron |
            theError := theError + ((nextNeuron weights at: j) * nextNeuron delta)
        ].
        neuron adjustDeltaWith: theError
    ].

    self previousLayer notNil
        ifTrue: [
             self previousLayer backwardPropagateError ].
]

{ #category : #'as yet unclassified' }
NeuronLayer >> backwardPropagateError: expected [
    "This is a recursive method. The back propagation begins with the output layer (i.e., the last layer)"
    "We are in the output layer"
    neurons with: expected do: [ :neuron :exp | 
        | theError |
        theError := exp - neuron output.
        neuron adjustDeltaWith: theError ].

    "We iterate"
    self previousLayer notNil
        ifTrue: [
             self previousLayer backwardPropagateError ].
]

{ #category : #initialization }
NeuronLayer >> feed: someInputValues [
    "Feed the neuron layer with some inputs"

    | someOutputs |
    someOutputs := neurons collect: [ :n | n feed: someInputValues ] as: Array.
    ^ self isOutputLayer
        ifTrue: [ someOutputs ]
        ifFalse: [ nextLayer feed: someOutputs ]
]

{ #category : #initialization }
NeuronLayer >> initializeNbOfNeurons: nbOfNeurons nbOfWeights: nbOfWeights using: random [
    "Main method to initialize a neuron layer
    nbOfNeurons : number of neurons the layer should be made of
    nbOfWeights : number of weights each neuron should have
    random : a random number generator
    "
    | weights |
    neurons := (1 to: nbOfNeurons) collect: [ :i |
        weights := (1 to: nbOfWeights) collect: [ :ii | random next * 4 - 2 ].
        Neuron new sigmoid; weights: weights; bias: (random next * 4 - 2) ].
	self learningRate: 0.1
]

{ #category : #initialization }
NeuronLayer >> isOutputLayer [
    "Return true of the layer is the output layer (i.e., the last layer in the network)"
    ^ self nextLayer isNil
]

{ #category : #accessing }
NeuronLayer >> learningRate: aLearningRate [
	"Set the learning rate for the neurons"
	neurons do: [ :n | n learningRate: aLearningRate ]
]

{ #category : #initialization }
NeuronLayer >> neurons [
    "Return the neurons I am composed of"
    ^ neurons
]

{ #category : #initialization }
NeuronLayer >> nextLayer [
    "Return the next layer connected to me"
    ^ nextLayer
]

{ #category : #initialization }
NeuronLayer >> nextLayer: aLayer [
    "Set the next layer"
    nextLayer := aLayer
]

{ #category : #initialization }
NeuronLayer >> numberOfNeurons [
    "Return the number of neurons in the layer"
    ^ neurons size
]

{ #category : #initialization }
NeuronLayer >> previousLayer [
    "Return the previous layer connected to me"
    ^ previousLayer
]

{ #category : #initialization }
NeuronLayer >> previousLayer: aLayer [
    "Set the previous layer"
    previousLayer := aLayer
]

{ #category : #'as yet unclassified' }
NeuronLayer >> updateWeight [
    "Update the weights of the neuron based on the set of initial input. This method assumes that the receiver of the message invoking that method is the first hidden layer.
    We are now in the second hidden layers or in the output layer" 
    | inputs |
    inputs := self previousLayer neurons collect: #output.
        
    self updateWeight: inputs
]

{ #category : #'as yet unclassified' }
NeuronLayer >> updateWeight: initialInputs [
    "Update the weights of the neuron based on the set of initial input. This method assumes that the receiver of the message invoking that method is the first hidden layer."
    | inputs |
    inputs := initialInputs.
        
    neurons do: [ :n |
        n adjustWeightWithInput: inputs.
        n adjustBias ].
    
    self nextLayer ifNotNil: [ 
        self nextLayer updateWeight ]
]
