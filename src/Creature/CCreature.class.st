Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'muscles',
		'alpha'
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
	| m r n1 n2 tryNewNode1 tryNewNode2 |
	r := Random seed: 42.
	nbNodes timesRepeat: [ nodes add: (CNode new) ].
	nbMuscle timesRepeat: [ 
		m := CMuscle new.
		
		n1 := nodes atRandom: r.
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
					whileTrue: [ tryNewNode2 := tryNewNode2 + 1. n2 := nodes atRandom: r ].

					tryNewNode2 = 10 ifTrue: [ tryNewNode1 := tryNewNode1 + 1. tryNewNode2 := 0. n1 := nodes atRandom: r  ]
					 ].

"		[ (try <= 10 or: [ n2 == n1]) or: [ muscles anySatisfy: [ :mm | mm usesNodes: { n1 . n2 } ] ] ]  
			whileTrue: [ try := try + 1. n2 := nodes atRandom: r ].
"		
		m node1: n1.
		m node2: n2.
		m contractedLength: 10 + (r nextInt: 30).
		m extendedLength: (r nextInt: 30) + (m contractedLength).
		m contractedTime: (r nextInt: m maxTime - 4) + 2.
		m strenght: (r nextInt: 5) + 2.
		
		muscles add: m ].
	
	nodes do: #createElement.
	muscles do: #createElement.
	
	nodes do: [ :n | n translateBy: (r nextInt: 100) @ (r nextInt: 100) ]
]

{ #category : #initialization }
CCreature >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	muscles := OrderedCollection new.
	alpha := 0.3.
	
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
						from translateTo: (fp x + (x * k)) @ (fp y + (y * k)) ] 
	].

	nodes with: originalPositions do: [ :aNode :oldPosition | 
			wishedPosition := aNode position.
			friction := aNode isOnGround ifTrue: [ 0.5 ] ifFalse: [ 0 ].
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
	averageCenter := ((self nodes collect: #position) sum) / self nodes size.
	delta := aPoint - averageCenter.
	self nodes do: [ :n | n translateBy: delta ]
]
