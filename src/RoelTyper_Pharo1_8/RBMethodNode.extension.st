Extension { #name : 'RBMethodNode' }

{ #category : '*RoelTyper_Pharo1_8' }
RBMethodNode >> generateMethodByCompiler: aCompiler [

	self compilationContext: aCompiler compilationContext.
	^ self generate
]
