Extension { #name : 'ASTBlockNode' }

{ #category : '*RoelTyper_Pharo13' }
ASTBlockNode >> ownTempNames [

	^ PharoTypeCollector ownTempNamesForBlockNode: self
]
