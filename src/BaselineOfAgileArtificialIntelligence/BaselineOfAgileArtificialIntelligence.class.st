Class {
	#name : #BaselineOfAgileArtificialIntelligence,
	#superclass : #BaselineOf,
	#category : #BaselineOfAgileArtificialIntelligence
}

{ #category : #baselines }
BaselineOfAgileArtificialIntelligence >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [			
			spec baseline: 'Roassal2' with: [ 
				spec repository: 'github://ObjectProfile/Roassal2/src' ].
					
			spec package: 'NeuralNetwork' with: [ spec requires: #('Roassal2') ].
			spec package: 'GeneticAlgorithm' with: [ spec requires: #('Roassal2') ].
			spec package: 'Creatures' with: [ spec requires: #('GeneticAlgorithm') ].
			
			spec group: 'default' with: #('Roassal2' 'NeuralNetwork' 'GeneticAlgorithm' 'Creatures').
			 ]
]
