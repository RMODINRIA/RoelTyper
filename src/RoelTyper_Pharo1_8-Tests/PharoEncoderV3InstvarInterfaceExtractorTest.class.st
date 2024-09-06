Class {
	#name : 'PharoEncoderV3InstvarInterfaceExtractorTest',
	#superclass : 'InstvarInterfaceExtractorTest',
	#category : 'RoelTyper_Pharo1_8-Tests-Tests',
	#package : 'RoelTyper_Pharo1_8-Tests',
	#tag : 'Tests'
}

{ #category : 'tests - message sends' }
PharoEncoderV3InstvarInterfaceExtractorTest >> testNestedBlocksComplex [
	| collector results |
	collector := TypeCollector new.
	results := collector
		typeTmpsIn: ASampleClass >> #nestedBlocksComplex:
		ofClass: ASampleClass.
	self
		assertCollection: results keys
		hasSameElements:
			#(#'^' #mArg #mTemp1 #mTemp2 #mTemp3 #'_block1->b1Arg' #'_block1->b1Temp' #'_block2->b2Temp1Shadowed' #'_block2->b2Temp2' #'_block3->b2b1Arg' #'_block3->b2b1Temp' #'_block3->b2Temp1Shadowed').
	self assertCollection: (results at: #'^') assignments hasSameElements: {ASampleClass}.
	self assertCollection: (results at: #mArg) assignments hasSameElements: {Array}.
	self assertCollection: (results at: #mArg) interface hasSameElements: {#asArray}.
	self assertCollection: (results at: #mTemp1) assignments hasSameElements: {SmallInteger}.
	self assert: ((results at: #mTemp1) interface includesAll: {#lastDigit . #+}).
	self
		assertCollection: (results at: #mTemp2) interface
		hasSameElements: {#primeFactors . #noMask:}.
	self assertCollection: (results at: #mTemp3) assignments hasSameElements: {}.
	self assertCollection: (results at: #mTemp3) interface hasSameElements: {#-}.
	self assertCollection: (results at: #'_block1->b1Arg') assignments hasSameElements: {}.
	self
		assertCollection: (results at: #'_block1->b1Arg') interface
		hasSameElements: {#isInfix}.
	self
		assertCollection: (results at: #'_block1->b1Temp') interface
		hasSameElements: {#capitalized}.
	self
		assertCollection: (results at: #'_block2->b2Temp1Shadowed') assignments
		hasSameElements: {Character}.
	self
		assertCollection: (results at: #'_block2->b2Temp1Shadowed') interface
		hasSameElements: {#digitValue}.
	self
		assertCollection: (results at: #'_block2->b2Temp2') interface
		hasSameElements: {#value}.
]

{ #category : 'tests - message sends' }
PharoEncoderV3InstvarInterfaceExtractorTest >> testNestedBlocksUsingOuterTemps [

	| collector results |
	collector := TypeCollector new.
	results := collector
		           typeTmpsIn: ASampleClass >> #nestedBlocksUsingOuterTemps
		           ofClass: ASampleClass.
	self
		assertCollection: results keys
		hasSameElements:
		#( #'^' #t1 #tb1 #'_block1->t2' #'_block1->tb2' #'_block2->t3' ).
	self
		assertCollection: (results at: #'^') assignments
		hasSameElements: { ASampleClass }.
]

{ #category : 'tests - message sends' }
PharoEncoderV3InstvarInterfaceExtractorTest >> testNestedBlocksWithTemps [

	| collector results |
	collector := TypeCollector new.
	results := collector
		           typeTmpsIn: ASampleClass >> #nestedBlocksWithTemps
		           ofClass: ASampleClass.
	self
		assertCollection: results keys
		hasSameElements: #( #'^' #t1 #'_block1->t2' #'_block1->t3' #'_block2->t4' ).
	self
		assertCollection: (results at: #'^') assignments
		hasSameElements: { ASampleClass }.
]

{ #category : 'tests - message sends' }
PharoEncoderV3InstvarInterfaceExtractorTest >> testStreamContents [

	| collector results |
	collector := TypeCollector new.
	results := collector
		           typeTmpsIn: ASampleClass >> #streamContents
		           ofClass: ASampleClass.
	self
		assertCollection: results keys
		hasSameElements: #( #'^' #array #string #'_block2->stream' #'_block3->each' ).
	self
		assertCollection: (results at: #'^') assignments
		hasSameElements: { ASampleClass }.
	self
		assertCollection: (results at: #array) interface
		hasSameElements: { #isEmpty. #do:separatedBy: }.
	self
		assertCollection: (results at: #string) interface
		hasSameElements: {  }.
		
	
]
