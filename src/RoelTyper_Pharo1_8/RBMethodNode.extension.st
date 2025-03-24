Extension { #name : 'RBMethodNode' }

{ #category : '*RoelTyper_Pharo1_8' }
RBMethodNode >> allOwnTempNames [

	^ self allOwnTempNamesByOwners flattened
]

{ #category : '*RoelTyper_Pharo1_8' }
RBMethodNode >> allOwnTempNamesByOwners [

	^ ({ (self -> self ownTempNames) }
	   , (self blockNodes collect: [ :each | each -> each ownTempNames ]))
		  asOrderedDictionary
]

{ #category : '*RoelTyper_Pharo1_8' }
RBMethodNode >> generateMethodByCompiler: aCompiler [

	self compilationContext: aCompiler compilationContext.
	^ self generate
]

{ #category : '*RoelTyper_Pharo1_8' }
RBMethodNode >> ownTempNames [

	| tempNames |
	tempNames := self scope tempVarNames asOrderedCollection.
	self scope tempVector
		collect: [ :each | each name ]
		thenDo: [ :each | tempNames addIfNotPresent: each ].
	^ tempNames
]