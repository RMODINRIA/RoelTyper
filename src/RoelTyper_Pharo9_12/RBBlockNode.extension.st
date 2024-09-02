Extension { #name : 'RBBlockNode' }

{ #category : '*RoelTyper_Pharo9_12' }
RBBlockNode >> ownTempNames [

	^ PharoTypeCollector ownTempNamesForBlockNode: self
]
