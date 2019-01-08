"
Example of use:

-=-=-=-=-=-=
creature := CCreature new configureNbNodes: 4 nbMuscles: 5.
c := CCanvas new.
c addPlatform: CPlatform new.
c addCreature: creature.
c beat.
c open
-=-=-=-=-=-=
	
"
Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'nodes',
		'muscles',
		'alpha',
		'random',
		'muscleGenerator'
	],
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CCreature >> addMuscleFrom: aNode to: anotherNode [

	muscles add: (muscleGenerator createMuscleFrom: aNode to: anotherNode)
]

{ #category : #'as yet unclassified' }
CCreature >> addMuscleFrom: aNode to: anotherNode maxStrength: maxStrength minLength: minLength [

	| m |
	self halt.
	m := CMuscle new.
	m node1: aNode.
	m node2: anotherNode.
	m length1: minLength + (random nextInt: 30).
	m length2: minLength + (random nextInt: 30).
	
"	m contractedLength: 30.
	m extendedLength: 30.
"	
	m contractedTime: (random nextInt: m maxTime - 4) + 2.
	m strenght: (random next * maxStrength) + 0.3.
	muscles add: m.
]

{ #category : #accessing }
CCreature >> beat [
	nodes do: #beat.
	muscles do: #beat.
	self reachStable
]

{ #category : #accessing }
CCreature >> checkForCollision: platforms [
	"This is an optimized version of :
	
	
	nodes do: [ :n | n checkForCollision: platforms ].
	(nodes allSatisfy: [ :n | n position y = nodes first position y ]) ifTrue: [ 
		nodes first translateBy: 0 @ -2.
		nodes last translateBy: 0 @ -2 ]
"
	| allAtTheSameLevel tmpLevel |
	allAtTheSameLevel := true.
	tmpLevel := nil.
	nodes doWithIndex: [ :n :index | 
		n checkForCollision: platforms.
		index = 1 
			ifTrue: [ tmpLevel := n position y ]
			ifFalse: [ n position y ~= tmpLevel ifTrue: [ allAtTheSameLevel ] ].
		 ].
	allAtTheSameLevel ifFalse: [ ^ self ]. 
	nodes first translateBy: 0 @ -2.
	nodes last translateBy: 0 @ -2 
]

{ #category : #'as yet unclassified' }
CCreature >> configureBall: numberOfNodes [
	| |
	
	numberOfNodes timesRepeat: [ 
		nodes add: CNode new
	].

	nodes do: [ :n1 |
		(nodes copyWithout: n1) do: [ :n2 |
			self addMuscleFrom: n1 to: n2.
		]
	].

	nodes do: #createElement.
	muscles do: #createElement.
	self resetNodes

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
			self addMuscleFrom: n1 to: n2].
	nodes do: #createElement.
	muscles do: #createElement.
	self resetNodes
]

{ #category : #'as yet unclassified' }
CCreature >> configureWorm: length [
	| lastTwoNodes n1 n2 index |
	
	"HEAD"
	nodes add: CNode new.
	nodes add: CNode new.
	lastTwoNodes := nodes last: 2.
	self addMuscleFrom: lastTwoNodes first to: lastTwoNodes second.
	
	length timesRepeat: [
		n1 := CNode new.
		n2 := CNode new.
		nodes add: n1.
		nodes add: n2.
		self addMuscleFrom: lastTwoNodes first to: n1.
		self addMuscleFrom: lastTwoNodes second to: n1.
		self addMuscleFrom: lastTwoNodes first to: n2.
		self addMuscleFrom: lastTwoNodes second to: n2.
		self addMuscleFrom: n1 to: n2.
	
		lastTwoNodes := Array with: n1 with: n2.
		].

	nodes do: #createElement.
	muscles do: #createElement.
	
	index := 0.
	nodes pairsDo: [ :aNode :aSecondNode | 
		aNode translateBy: (index * 10) @ 0. 
		aSecondNode translateBy: (index * 10) @ 10.
		index := index + 1 ]
	
]

{ #category : #initialization }
CCreature >> initialize [
	super initialize.
	nodes := OrderedCollection new.
	muscles := OrderedCollection new.
	alpha := 0.3.
	random := Random seed: 42.
	muscleGenerator := CMuscleGenerator new
]

{ #category : #serialization }
CCreature >> materialize: anArrayOfValues [
	| valuesPerMuscles |
	valuesPerMuscles := anArrayOfValues groupsOf: 5 atATimeCollect: [ :v | v ].

	muscles with: valuesPerMuscles do: [ :m :values | 
		muscleGenerator materialize: values inMuscle: m ]
]

{ #category : #accessing }
CCreature >> muscleGenerator [
	^ muscleGenerator
]

{ #category : #accessing }
CCreature >> muscleGenerator: aMuscleGenerator [
	muscleGenerator := aMuscleGenerator
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
		actualLength := delta r max: 1.
		unit := delta / actualLength.
		force := 0.1 * m strenght * (actualLength - m length) * unit.
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
						len := m strenght * (len - m length) / (len + 1) / 10.
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
	^ (muscles
		flatCollect: [ :m | 
			muscleGenerator serializeMuscle: m ]) asArray
]

{ #category : #actions }
CCreature >> translateTo: aPoint [
	| averageCenter delta |
	averageCenter := self position.
	delta := aPoint - averageCenter.
	self nodes do: [ :n | n translateBy: delta ]
]
