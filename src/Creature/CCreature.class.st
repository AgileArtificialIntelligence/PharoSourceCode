Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'clock',
		'nodes',
		'muscles',
		'alpha',
		'time'
	],
	#category : #Creature
}

{ #category : #accessing }
CCreature >> beat [
	muscles do: #beat
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
		m extendedTime: m maxTime - m contractedTime. "Probably not useful. This extendedTime should be removed!"
		
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
	alpha := 0.1.
	time := 0
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
	| k from fp to tp x y len |
	alpha := alpha * 0.99.
	alpha < 0.005 ifTrue: [ ^ self ].
	nodes do: [ :n | n disp: 0 ].
	muscles do: [ :m | 
					from := m node1. 
					fp := from position.
					to := m node2. 
					tp := to position.
					x := tp x - fp x.
					y := tp y - fp y.
					len := ((x * x) + (y * y)) sqrt.
					((len closeTo: 0) not) ifTrue: [ 
						len := alpha * (m strenght) * (len - (m length)) / len.
						x := x * len.
						y := y * len.
						"k := (weights at: from) / (( weights at: from) +( weights at: to ))."
						k := 0.5.
						to translateTo: (tp x - (x * k)) @ (tp y - (y * k)).
						k := 1 - k.
						from translateTo: (fp x + (x * k))@(fp y + (y * k)) ] 
	].

	"nodes do: [ :e | 
			old := e position.
			e translateTo: 
				(old x - (( (oldPositions at: e) x - old x ) * friction)) @ 
				(old y - (( (oldPositions at: e) y - old y ) * friction)).
			oldPositions at: e put: old.].
 "
]
