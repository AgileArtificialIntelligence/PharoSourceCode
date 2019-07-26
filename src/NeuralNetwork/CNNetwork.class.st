"
This class represent Convolutional neural networks.

This class allow to create, configure and manage this kind of network.

@yvanGuemkam

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #CNNetwork,
	#superclass : #Object,
	#instVars : [
		'layers',
		'errors',
		'precisions'
	],
	#category : #'NeuralNetwork-Core'
}

{ #category : #'as yet unclassified' }
CNNetwork class >> exampleWithMNIST [

| net fileBase reader reader2 matrix matrix2 datas labels data3D r cl1 pl1 cl2 nl |
fileBase := 'C:\Users\vanor\Desktop\cle_yvan\NewAge\datasets\mnist\'.
reader := IdxReader onStream: (File named: (fileBase , 'train-images-idx3-ubyte')) readStream.
reader2 := IdxReader onStream: (File named: (fileBase , 'train-labels-idx1-ubyte')) readStream.
matrix := reader next.
matrix2 := reader2 next.

datas := matrix first: 50.
labels := matrix2 first: 50.
data3D := datas collect: [ :row | row collect: [ :c | c collect: [ :e | { e } ] ] ].


r := Random seed: 42.
cl1 := CNeuronLayer new initializeForNbOfFeatures: 10 withWidth: 6 height: 6 depth: 1 andOutputSize: 12.
cl1 stride: 2.
pl1 := PoolingLayer new initializeForReceptiveFieldSize: 2 withStride: 2.
cl2 := CNeuronLayer new initializeForNbOfFeatures: 16 withWidth: 6 height: 6 depth: 10 andOutputSize: 1.
cl2 stride: 1.
nl := NeuronLayer new.
nl initializeNbOfNeurons: 10 nbOfWeights: 16 using: r.
net := CNNetwork new.
net addLayer: cl1; addLayer: pl1; addLayer: cl2; addLayer: nl.


net train: data3D withLabels: labels andNbEpoch: 20.
]

{ #category : #adding }
CNNetwork >> addLayer: aLayer [
	"To add a layer to a convolutional neural network."
	
	layers ifNotEmpty: [ 
		aLayer previousLayer: layers last.
		layers last nextLayer: aLayer ].
	layers add: aLayer.
]

{ #category : #initialization }
CNNetwork >> backwardPropagateError: expectedOutputs [
	"To propagate the error on expectedOutputs corresponding to the desired outputs on a trainig sample."

	self outputLayer backwardPropagateError: expectedOutputs
]

{ #category : #initialization }
CNNetwork >> feed: anInputVolume [
	"To feed the network with a specific input value."

	^ layers first feed: anInputVolume
]

{ #category : #initialization }
CNNetwork >> initialize [
	"To properly initialize the network."

	layers := OrderedCollection new.
	errors := OrderedCollection new.
	precisions := OrderedCollection new.
]

{ #category : #accessing }
CNNetwork >> layers [
	"To get all the layers of the network."

	^ layers
]

{ #category : #initialization }
CNNetwork >> learningRate: aLearningRate [
	"To set the learning rate of the whole networkk with a specific value."

	layers do: [ :layer |
		layer class = PoolingLayer ifFalse: [ layer learningRate: aLearningRate ] ]
]

{ #category : #initialization }
CNNetwork >> numberOfOutputs [
	"To get the number of output of the network."

	^ layers last numberOfNeurons
]

{ #category : #initialization }
CNNetwork >> outputLayer [
	"To get the output layer of the network."

	^ layers last
]

{ #category : #'as yet unclassified' }
CNNetwork >> outputWidth [
	"To get the output width of a the first convolutional layer of the network."

	self assert: [ layers first neurons notEmpty ] description: 'outputWidth should be invoked after configuring the layer'.
	^ layers first neurons size.
]

{ #category : #running }
CNNetwork >> predict: inputs [
	"To make a prediction. This method assumes that the number of outputs is the same than the number of different values the network can output."

	| outputs |
	outputs := self feed: inputs.
	^ (outputs indexOf: (outputs max)) - 1
]

{ #category : #initialization }
CNNetwork >> train: trainingSet withLabels: labelSet andNbEpoch: nbOfEpoch [
	"To train the network using the training data set."

	| sumError outputs expectedOutputs epochPrecision t |
	1 to: nbOfEpoch do: [ :epoch |
		sumError := 0.
		epochPrecision := 0.
		trainingSet with: labelSet do: [ :data :label |
			outputs := self feed: data.
			expectedOutputs := (1 to: self numberOfOutputs) collect: [ :notUsed | 0 ].
			expectedOutputs at: label + 1 put: 1.
			(label = (self predict: data)) ifTrue: [ epochPrecision := epochPrecision + 1 ].
			t := (1 to: expectedOutputs size)
						collect: [ :i | ((expectedOutputs at: i) - (outputs at: i)) raisedTo: 2 ].
			sumError := sumError + t sum.
			
			self backwardPropagateError: expectedOutputs.
			self updateWeights.
		].
		errors add: sumError.
		precisions add: (epochPrecision / trainingSet size) asFloat.
	]
]

{ #category : #initialization }
CNNetwork >> updateWeights [
	"To update the weights of the neurons using the padded inputs."

	layers first updateWeights
]
