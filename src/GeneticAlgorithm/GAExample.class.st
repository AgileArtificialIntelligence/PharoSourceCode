Class {
	#name : #GAExample,
	#superclass : #Object,
	#category : #'GeneticAlgorithm-Core'
}

{ #category : #'as yet unclassified' }
GAExample >> fundamentalTheoremArithmetic [
	| g numberOfIdentifyFactors primeNumbers candidateFactors |
	
	numberOfIdentifyFactors := 345.
	primeNumbers := #(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199).
	candidateFactors := #(1), primeNumbers.
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 10000.
	g numberOfGenes: 10.
	g createGeneBlock: [ :rand :index :ind | candidateFactors atRandom: rand ].
	g minimizeComparator.
	g
		fitnessBlock: [ :genes | 
			((genes inject: 1 into: [ :r :v | r * v ]) - numberOfIdentifyFactors) abs ].
	g run.
	
	(g result copyWithout: 1) inject: 1 into: [ :r :v | r * v ]
	

]

{ #category : #'as yet unclassified' }
GAExample >> roomSchedulingProblem [

	"We assume that each meeting is correctly defined"	
	"a meeting = (start time, end time)"
	| meetings numberOfMeetings g numberOfOverlap table |
	meetings := #(#(1 3) #(2 3) #(5 6) #(7 9) #(4 7)).
	numberOfMeetings := meetings size.
	
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: numberOfMeetings.
	g createGeneBlock: [ :rand :index :ind | (1 to: numberOfMeetings) atRandom: rand ].
	g minimizeComparator.
	g
		fitnessBlock: [ :genes | 
			| distribution |
			distribution := OrderedCollection new.
			numberOfMeetings timesRepeat: [ distribution add: OrderedCollection new ].
			genes doWithIndex: [ :roomNumber :index | (distribution at: roomNumber) add: (meetings at: index) ].
			
			numberOfOverlap := 0.
			distribution do: [ :aSetOfMeetings |
				table := OrderedCollection new: 10 withAll: 0.
				aSetOfMeetings do: [ :meet |
					meet first to: meet second do: [ :v | table at: v put: (table at: v) + 1 ]
				].
				numberOfOverlap := numberOfOverlap + (table select: [ :v | v >= 2 ]) size.
			].

			(distribution select: #notEmpty) size + numberOfOverlap.
	
			 ].
	g run.
g logs.
g result asSet size
]

{ #category : #'as yet unclassified' }
GAExample >> tsp [
"Travelling salesman problem"

| points tmp g result v elements |
points := ((Array new: 20) at: 1 put: ((100@160)); at: 2 put: ((20@40)); at: 3 put: ((60@20)); at: 4 put: ((180@100)); at: 5 put: ((200@40)); at: 6 put: ((60@200)); at: 7 put: ((80@180)); at: 8 put: ((40@120)); at: 9 put: ((140@180)); at: 10 put: ((140@140)); at: 11 put: ((20@160)); at: 12 put: ((200@160)); at: 13 put: ((180@60)); at: 14 put: ((100@120)); at: 15 put: ((120@80)); at: 16 put: ((100@40)); at: 17 put: ((20@20)); at: 18 put: ((60@80)); at: 19 put: ((180@200)); at: 20 put: ((160@20)); yourself).

tmp := nil.

    g := GAEngine new.
	g endForMaxNumberOfGeneration: 100.
	g mutationRate: 0.15.
    g populationSize: 60.
    g numberOfGenes: points size.
	g crossoverOperator:  GAOrderedCrossoverOperation new.
	g beforeCreatingInitialIndividual: [ :rand | tmp := points copy shuffleBy: rand ].
		g mutationOperator: GASwapMutationOperation new.
    g createGeneBlock: [ :rand :index :ind | tmp at: index ].

	g minimizeComparator.
    g fitnessBlock: [ :genes |
		| distance d |
		distance := 0.
		2 to: genes size do: [ :pointIndex |
			d := (genes at: pointIndex) dist: (genes at: pointIndex - 1).
			distance := distance + (d ) ].
		distance ].
    
    g run.


result := g result.
v := RTView new.
elements := RTEllipse new size: 10; color: Color red trans; elementsOn: result.
elements @ RTPopup.
v addAll: elements.
elements do: [ :e | e translateTo: e model ].
2 to: result size do: [ :index |
	| l |
	l := RTArrowedLine new color: Color blue; headOffset: 0.8.
	v add: (l edgeFrom: (v elementFromModel: (result at: index - 1)) to: (v elementFromModel: (result at: index))) ].
v
]

{ #category : #'as yet unclassified' }
GAExample >> unboundedKnapsackProblem [
	| knapsackMaxWeight boxes g |
	knapsackMaxWeight := 15.
	"a box = (value, weight)"
	boxes := #(#(4 12) #(2 1) #(2 2) #(1 1) #(10 4) #(0 0)).
	
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: 15.
	g createGeneBlock: [ :rand :index :ind | boxes atRandom: rand ].
	g maximizeComparator.
	g
		fitnessBlock: [ :genes | 
			| totalWeight totalValue penalty |
			totalValue := (genes collect: #first) sum.
			totalWeight := (genes collect: #second) sum.
			penalty := (knapsackMaxWeight - totalWeight) abs * 50.
			totalValue - penalty
			 ].
	g run.
(	g result collect: #second) sum.
	(	g result collect: #first) sum.
	g result copyWithout: #(0 0)
]

{ #category : #'as yet unclassified' }
GAExample >> zeroOneKnapsackProblem [
	| knapsackMaxWeight boxes g decodeToBoxes |
	knapsackMaxWeight := 15.
	"a box = (value, weight)"
	boxes := #(#(4 12) #(2 1) #(2 2) #(1 1) #(10 4) ).
	
	g := GAEngine new.
	g endIfNoImprovementFor: 10.
	g populationSize: 20000.
	g numberOfGenes: boxes size.
	g createGeneBlock: [ :rand :index :ind | #(0 1) atRandom: rand ].
	g maximizeComparator.
	g
		fitnessBlock: [ :genes | 
			| totalWeight totalValue penalty |
			decodeToBoxes := OrderedCollection new.
			genes doWithIndex: [ :b :ind | b = 1 ifTrue: [ decodeToBoxes add: (boxes at: ind) ] ].
			decodeToBoxes add: #(0 0).
			totalValue := (decodeToBoxes collect: #first) sum.
			totalWeight := (decodeToBoxes collect: #second) sum.
			knapsackMaxWeight < totalWeight 
				ifTrue: [ penalty := (knapsackMaxWeight - totalWeight) abs * 100 ]
				ifFalse: [ penalty := 0 ].
			
			totalValue - penalty
			 ].
	g run.

decodeToBoxes := OrderedCollection new.
g result doWithIndex: [ :b :ind | b = 1 ifTrue: [ decodeToBoxes add: (boxes at: ind) ] ].
decodeToBoxes
]
