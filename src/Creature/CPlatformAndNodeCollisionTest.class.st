Class {
	#name : #CPlatformAndNodeCollisionTest,
	#superclass : #TestCase,
	#category : #Creature
}

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test01 [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ -20.
	
	self deny: (p touch: n)
]

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test02 [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ -5.
	
	self assert: (p touch: n)
]

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test03 [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ (n nodeSize / 2) negated.
	
	self assert: (p touch: n)
]

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test04 [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ -5.
	"n element translateTo: 0 @ ((n nodeSize / 2) negated - 1)."
	
	self assert: (p touch: n)
]

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test05 [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ -15.
	"n element translateTo: 0 @ ((n nodeSize / 2) negated - 1)."
	
	self deny: (p touch: n)
]

{ #category : #tests }
CPlatformAndNodeCollisionTest >> test06Adjust [
	| p n |
	p := CPlatform new.
	p createElement.
	p element translateTo: 0 @ 0.

	n := CNode new.
	n createElement.
	n element translateTo: 0 @ -6.
	
	self assert: (p touch: n).
	self assert: n element position equals: 0 @ -6.
	
	p adjustNodeIfNecessary: n.
	self assert: (p touch: n).
	self assert: n element position equals: 0 @ -10.
]
