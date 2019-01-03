Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'muscles',
		'alpha',
		'random'
	],
	#category : #Creature
}

{ #category : #accessing }
CCreature >> beat [
	nodes do: #beat.
	muscles do: #beat.
	self reachStable
]

{ #category : #accessing }
CCreature >> checkForCollision: platforms [
	nodes do: [ :n | n checkForCollision: platforms ]
]

{ #category : #'as yet unclassified' }
CCreature >> configureNbNodes: nbNodes nbMuscles: nbMuscle [
	| m n1 n2 tryNewNode1 tryNewNode2 |
	nbNodes timesRepeat: [ nodes add: (CNode new) ].
	nbMuscle timesRepeat: [ 
		m := CMuscle new.
		
		n1 := nodes atRandom: random.
		n2 := n1.
		tryNewNode1 := 0.
		tryNewNode2 := 0.
		
		"We want to avoid nodes to have more than one muscles between them.
		We look for nodes if:
			- there is less than 10 tries
			- we look for another node if 
				- the two nodes are the same, or 
				- at least one muscle uses the two nodes"
		
		[ (tryNewNode1 < 10) and: [ (n2 == n1) or: [ muscles anySatisfy: [ :mm | mm usesNodes: { n1 . n2 } ] ] ] ]
			whileTrue: [

				[ (tryNewNode2 < 10) and: [ (n2 == n1) or: [ muscles anySatisfy: [ :mm | mm usesNodes: { n1 . n2 } ] ] ] ]
					whileTrue: [ tryNewNode2 := tryNewNode2 + 1. n2 := nodes atRandom: random ].

					tryNewNode2 = 10 ifTrue: [ tryNewNode1 := tryNewNode1 + 1. tryNewNode2 := 0. n1 := nodes atRandom: random  ]
					 ].

"		[ (try <= 10 or: [ n2 == n1]) or: [ muscles anySatisfy: [ :mm | mm usesNodes: { n1 . n2 } ] ] ]  
			whileTrue: [ try := try + 1. n2 := nodes atRandom: r ].
"		
		m node1: n1.
		m node2: n2.

		m contractedLength: 10 + (random nextInt: 30).
		m extendedLength: 10 + (random nextInt: 30).
		
"		m contractedLength: 10 + (r nextInt: 30).
		m extendedLength: (r nextInt: 30) + (m contractedLength)."
		m contractedTime: (random nextInt: m maxTime - 4) + 2.
		m strenght: (random nextInt: 4) + 2.
		
		muscles add: m ].
	
	nodes do: #createElement.
	muscles do: #createElement.
	
	nodes do: [ :n | n translateBy: (random nextInt: 100) @ (random nextInt: 100) ]
]

{ #category : #initialization }
CCreature >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	muscles := OrderedCollection new.
	alpha := 0.3.
	random := Random seed: 42.
	
]

{ #category : #serialization }
CCreature >> materialize: anArrayOfValues [
	| valuesPerMuscles |
	valuesPerMuscles := anArrayOfValues groupsOf: 3 atATimeCollect: [ :v | v ].
	muscles with: valuesPerMuscles do: [ :m :values | 
		m contractedLength: values first. 
		m extendedLength: values second.
		m strenght: values third ]
]

{ #category : #accessing }
CCreature >> muscles [
	^ muscles 
]

{ #category : #accessing }
CCreature >> nodes [
	^ nodes
	
]

{ #category : #actions }
CCreature >> position [
	^ (self nodes collect: #position) sum / self nodes size
]

{ #category : #'as yet unclassified' }
CCreature >> reachStable [
	| k from fp to tp x y len originalPositions wishedPosition friction |
	originalPositions := nodes collect: #position.
	muscles do: [ :m | 
					from := m node1. 
					fp := from position.
					to := m node2. 
					tp := to position.
					x := tp x - fp x.
					y := tp y - fp y.
					len := ((x * x) + (y * y)) sqrt.
					(len closeTo: 0) ifFalse: [ 
						len := alpha * (m strength) * (len - (m length)) / len.
						x := x * len.
						y := y * len.
						"k := (weights at: from) / (( weights at: from) +( weights at: to ))."
						k := 0.5.
						to translateTo: (tp x - (x * k)) @ (tp y - (y * k)).
						k := 1 - k.
						from translateTo: (fp x + (x * k)) @ (fp y + (y * k)) ].
					
					self haltIf: [ to position x > 300 ].
	].

	nodes with: originalPositions do: [ :aNode :oldPosition | 
			wishedPosition := aNode position.
			friction := aNode isOnGround ifTrue: [ 1 ] ifFalse: [ 0.5 ].
			aNode translateTo: 
				(wishedPosition x - ((oldPosition x - wishedPosition x) * friction)) @ 
				(wishedPosition y - ((oldPosition y - wishedPosition y) * friction)) ].
	originalPositions removeAll
]

{ #category : #serialization }
CCreature >> serialize [
	
	^ (muscles flatCollect: [ :m | Array with: m contractedLength with: m extendedLength with: m strength ]) asArray
]

{ #category : #actions }
CCreature >> translateTo: aPoint [
	| averageCenter delta |
	averageCenter := self position.
	delta := aPoint - averageCenter.
	self nodes do: [ :n | n translateBy: delta ]
]
