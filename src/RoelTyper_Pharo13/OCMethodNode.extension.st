Extension { #name : 'OCMethodNode' }

{ #category : '*RoelTyper_Pharo13' }
OCMethodNode >> allOwnTempNames [

	^ self allOwnTempNamesByOwners flattened
]

{ #category : '*RoelTyper_Pharo13' }
OCMethodNode >> allOwnTempNamesByOwners [

	^ ({ (self -> self ownTempNames) }
	   , (self blockNodes collect: [ :each | each -> each ownTempNames ]))
		  asOrderedDictionary
]

{ #category : '*RoelTyper_Pharo13' }
OCMethodNode >> generateMethodByCompiler: aCompiler [

	^ self generateMethod
]

{ #category : '*RoelTyper_Pharo13' }
OCMethodNode >> ownTempNames [

	| tempNames |
	tempNames := self scope tempVarNames asOrderedCollection.
	self scope tempVector
		collect: [ :each | each name ]
		thenDo: [ :each | tempNames addIfNotPresent: each ].
	^ tempNames
]
