Class {
	#name : #CCreature,
	#superclass : #Object,
	#instVars : [
		'clock',
		'nodes',
		'muscles',
		'alpha'
	],
	#category : #Creature
}

{ #category : #'as yet unclassified' }
CCreature >> configureNbNodes: nbNodes nbMuscles: nbMuscle [
	| m r n1 n2 try |
	r := Random seed: 42.
	nbNodes timesRepeat: [ nodes add: (CNode new) ].
	nbMuscle timesRepeat: [ 
		m := CMuscle new.
		n1 := nodes atRandom: r.
		n2 := n1.
		try := 0.
		[ (try < 10 or: [ n2 == n1]) or: [ muscles anySatisfy: [ :mm | mm usesNodes: { n1 . n2 } ] ] ]  whileTrue: [ try := try + 1. n2 := nodes atRandom: r ].
		
		m node1: n1.
		m node2: n2.
		m contractedLength: 10 + (r nextInt: 30).
		m extendedLength: (r nextInt: 30) + (m contractedLength).
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
	alpha := 0.1
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
						len := alpha * (m strenght) * ( len - (m length) ) / len.
						x := x * len.
						y := y * len.
						"k := (weights at: from) / (( weights at: from) +( weights at: to ))."
						k := 0.5.
						to translateTo: ( tp x - (x * k) )@( tp y - (y * k) ).
						k := 1 -  k.
						from translateTo: ( fp x + (x * k) )@( fp y + (y * k) ) ] 
	].

	"nodes do: [ :e | 
			old := e position.
			e translateTo: 
				(old x - (( (oldPositions at: e) x - old x ) * friction)) @ 
				(old y - (( (oldPositions at: e) y - old y ) * friction)).
			oldPositions at: e put: old.].
 "
]

{ #category : #'as yet unclassified' }
CCreature >> reachStableOLD [
	| k f delta |
	nodes do: [ :n | n disp: 0 ].
	k := 5.
	f := [ :d | d * d / k ].
	muscles do: [ :m |
		delta := m delta.
		m node2 addToDisp: (delta / delta abs) negated * (f value: delta abs).
		m node1 addToDisp: (delta / delta abs) * (f value: delta abs).
	].

	nodes do: [ :n |
		n translateBy: (n disp / n disp r)
	]

 
]
