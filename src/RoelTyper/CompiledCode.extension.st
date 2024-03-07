Extension { #name : 'CompiledCode' }

{ #category : '*RoelTyper' }
CompiledCode >> inspectionBlocks [

	<inspectorPresentationOrder: 25 title: 'Blocks'>
	^ SpTreePresenter new
		  roots: { self };
		  children: [ :aCompiledCode |
			  aCompiledCode literals select: [ :aLiteral |
					  aLiteral isEmbeddedBlock ] ];
		  display: [ :aCompiledCode | aCompiledCode sourceNode sourceCode ];
		  expandAll;
		  yourself
]
