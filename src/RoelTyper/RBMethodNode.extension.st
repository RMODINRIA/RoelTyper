Extension { #name : 'RBMethodNode' }

{ #category : '*RoelTyper' }
RBMethodNode >> allOwnTempNames [

	^ self allOwnTempNamesByOwners flattened
]

{ #category : '*RoelTyper' }
RBMethodNode >> allOwnTempNamesByOwners [

	^ ({ (self -> self ownTempNames) }
	   , (self blockNodes collect: [ :each | each -> each ownTempNames ]))
		  asOrderedDictionary
]

{ #category : '*RoelTyper' }
RBMethodNode >> ownTempNames [

	| tempNames |
	tempNames := self scope tempVarNames asOrderedCollection.
	self scope tempVector
		collect: [ :each | each name ]
		thenDo: [ :each | tempNames addIfNotPresent: each ].
	^ tempNames
]
