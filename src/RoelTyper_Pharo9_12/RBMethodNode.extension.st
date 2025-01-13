Extension { #name : 'RBMethodNode' }

{ #category : '*RoelTyper_Pharo9_12' }
RBMethodNode >> allOwnTempNames [

	^ self allOwnTempNamesByOwners flattened
]

{ #category : '*RoelTyper_Pharo9_12' }
RBMethodNode >> allOwnTempNamesByOwners [

	^ ({ (self -> self ownTempNames) }
	   , (self blockNodes collect: [ :each | each -> each ownTempNames ]))
		  asOrderedDictionary
]

{ #category : '*RoelTyper_Pharo9_12' }
RBMethodNode >> generateMethodByCompiler: aCompiler [

	^ self generate
]

{ #category : '*RoelTyper_Pharo9_12' }
RBMethodNode >> ownTempNames [

	| tempNames |
	tempNames := self scope tempVarNames asOrderedCollection.
	self scope tempVector
		collect: [ :each | each name ]
		thenDo: [ :each | tempNames addIfNotPresent: each ].
	^ tempNames
]