Extension { #name : 'OCBlockNode' }

{ #category : '*RoelTyper_Pharo13' }
OCBlockNode >> ownTempNames [

	^ PharoTypeCollector ownTempNamesForBlockNode: self
]
