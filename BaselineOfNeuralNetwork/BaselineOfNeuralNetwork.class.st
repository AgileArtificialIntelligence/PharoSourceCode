Class {
	#name : #BaselineOfNeuralNetwork,
	#superclass : #BaselineOf,
	#category : #BaselineOfNeuralNetwork
}

{ #category : #baselines }
BaselineOfNeuralNetwork >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			spec baseline: 'Roassal2' with: [ 
				spec repository: 'github://ObjectProfile/Roassal2/src' ].
					
			spec
				package: 'NeuralNetworks' with: [ spec requires: #('Roassal2') ].
				
			spec group: 'default' with: #('Roassal2' 'NeuralNetworks').
			]
]
