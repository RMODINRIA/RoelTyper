Extension { #name : 'RBBlockNode' }

{ #category : '*RoelTyper_Pharo1_8' }
RBBlockNode >> ownTempNames [

	^ PharoTypeCollector ownTempNamesForBlockNode: self
]
