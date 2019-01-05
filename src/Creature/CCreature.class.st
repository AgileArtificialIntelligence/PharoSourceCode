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
	nodes do: [ :n | n checkForCollision: platforms ].
	(nodes allSatisfy: [ :n | n position y = nodes first position y ]) ifTrue: [ 
		nodes first translateBy: 0 @ -2.
		nodes last translateBy: 0 @ -2 ]
]

{ #category : #'as yet unclassified' }
CCreature >> configureNbNodes: nbNodes nbMuscles: nbMuscle [
	| m n1 n2 tryNewNode1 tryNewNode2 |
	nbNodes timesRepeat: [ nodes add: CNode new ].
	nbMuscle
		timesRepeat: [ m := CMuscle new.
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
			[ tryNewNode1 < 10
				and: [ n2 == n1
						or: [ muscles
								anySatisfy: [ :mm | 
									mm
										usesNodes:
											{n1.
											n2} ] ] ] ]
				whileTrue: [ [ tryNewNode2 < 10
						and: [ n2 == n1
								or: [ muscles
										anySatisfy: [ :mm | 
											mm
												usesNodes:
													{n1.
													n2} ] ] ] ]
						whileTrue: [ tryNewNode2 := tryNewNode2 + 1.
							n2 := nodes atRandom: random ].
					tryNewNode2 = 10
						ifTrue: [ tryNewNode1 := tryNewNode1 + 1.
							tryNewNode2 := 0.
							n1 := nodes atRandom: random ] ].

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
			m strenght: (random nextInt: 3) + 1.
			muscles add: m ].
	nodes do: #createElement.
	muscles do: #createElement.
	self resetNodes
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

{ #category : #accessing }
CCreature >> random: aRandomGenerator [
	random := aRandomGenerator
]

{ #category : #'as yet unclassified' }
CCreature >> reachStable [
	| n1 n2 delta actualLength unit force |
	nodes do: #resetForce.
	muscles do: [ :m |
		n1 := m node1.
		n2 := m node2.
		delta := n2 position - n1 position.
		actualLength := delta r.
		unit := delta / actualLength.
		force := 0.1 * m strength * (actualLength - m length) * unit.
		n1 addForce: force.
		n2 addForce: force negated.
		 ].
	
]

{ #category : #'as yet unclassified' }
CCreature >> reachStableOLD [
	| k from fp to tp x y len originalPositions wishedPosition friction previousLen |
	originalPositions := nodes collect: #position.
	muscles do: [ :m | 
					from := m node1. 
					fp := from position.
					to := m node2. 
					tp := to position.
					x := tp x - fp x.
					y := tp y - fp y.
					len := ((x * x) + (y * y)) sqrt.
					self haltIf: [ x isNaN ].
					self haltIf: [ y isNaN ].
					(len closeTo: 0) ifFalse: [ 
						"len := alpha * (m strength) * (len - (m length)) / len."
						previousLen := len.
						len := m strength * (len - m length) / (len + 1) / 10.
"						len := 0.02 * m strength * (len - m length).
						len := len min: 200.
"						
						Transcript show: len asString; cr.
						self haltIf: [ len isNaN and: [ previousLen isNaN not ] ].
						x := x * len.
						y := y * len.
						"k := (weights at: from) / (( weights at: from) +( weights at: to ))."
						k := 0.5.
						
						self haltIf: [ (tp x - (x * k)) isInfinite ].
						self haltIf: [ (fp x + (x * k)) isInfinite ].
						self haltIf: [ (tp x - (x * k)) isNaN ].
						self haltIf: [ (fp x + (x * k)) isNaN ].
						to translateTo: (tp x - (x * k)) @ (tp y - (y * k)).
						k := 1 - k.
						from translateTo: (fp x + (x * k)) @ (fp y + (y * k)).
						
						"self haltIf: [ to position x > 300 ]."
						self haltIf: [ to position x isNaN ].
						
						 ].
					
					
	].

	nodes with: originalPositions do: [ :aNode :oldPosition | 
			wishedPosition := aNode position.
			friction := aNode isOnGround ifTrue: [ 0.5 ] ifFalse: [ 0.005 ].
			aNode translateTo: 
				(wishedPosition x - ((oldPosition x - wishedPosition x) * friction)) @ 
				(wishedPosition y - ((oldPosition y - wishedPosition y) * friction)) ].
	originalPositions removeAll
]

{ #category : #'as yet unclassified' }
CCreature >> resetNodes [
	nodes
		do: [ :n | n translateBy: (random nextInt: 50) @ (random nextInt: 50) ]
]

{ #category : #initialization }
CCreature >> resetPosition [
	self translateTo: 0 @ -50 .
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
