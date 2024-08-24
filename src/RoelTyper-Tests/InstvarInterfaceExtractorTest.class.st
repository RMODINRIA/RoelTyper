Class {
	#name : 'InstvarInterfaceExtractorTest',
	#superclass : 'RoelTypingTestRoot',
	#instVars : [
		'a',
		'b',
		'c',
		'u',
		'v',
		'w',
		'x',
		'y',
		'z'
	],
	#category : 'RoelTyper-Tests-Tests',
	#package : 'RoelTyper-Tests',
	#tag : 'Tests'
}

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> add1To: arg [
	"method used by compiled code in test"

	arg + 1
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> assertAssignments: description in: collector [
	| emptyIndexes ivarName ivarInterface extractedInterface ivarIndex anArray |
	anArray := collector typingResults.
	emptyIndexes := (1 to: self class allInstVarNames size) asOrderedCollection.
	description
		do:
			[:desc | 
			ivarName := desc first.
			ivarInterface := desc at: 2.
			ivarIndex := collector absoluteIndexForVar: ivarName.
			extractedInterface := collector assignmentsTo: ivarName.
			self assert: extractedInterface size equals: ivarInterface size.
			self
				assert:
					(extractedInterface allSatisfy: [:each | ivarInterface includes: each name]).
			emptyIndexes remove: ivarIndex].
	self
		emptyAssigment: anArray
		atIndexes: emptyIndexes
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> assertSends: description in: collector [
	| emptyIndexes ivarName ivarInterface extractedInterface ivarIndex anArray |
	anArray := collector typingResults.
	emptyIndexes := (1 to: self class allInstVarNames size) asOrderedCollection.
	description
		do:
			[:desc | 
			ivarName := desc first.
			ivarInterface := desc at: 2.
			ivarIndex := collector absoluteIndexForVar: ivarName.
			extractedInterface := collector sendsTo: ivarName.
			self assert: extractedInterface size equals: ivarInterface size.
			self
				assert:
					(extractedInterface allSatisfy: [:each | ivarInterface includes: each]).
			emptyIndexes remove: ivarIndex].
	self
		emptyInterface: anArray
		atIndexes: emptyIndexes
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> denyAssignments: description in: collector [
	| emptyIndexes ivarName ivarInterface extractedInterface ivarIndex anArray |
	anArray := collector typingResults.
	emptyIndexes := (1 to: self class allInstVarNames size) asOrderedCollection.
	description
		do:
			[:desc | 
			ivarName := desc first.
			ivarInterface := desc at: 2.
			ivarIndex := collector absoluteIndexForVar: ivarName.
			extractedInterface := collector assignmentsTo: ivarName.
			ivarInterface
				do: [:each | self deny: (extractedInterface includes: each)].
			emptyIndexes remove: ivarIndex].
	self
		emptyAssigment: anArray
		atIndexes: emptyIndexes
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> empty: anArray atIndexes: indexCollection [
	indexCollection do: [:index | self assert: (anArray at: index) isEmpty]
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> emptyAssigment: anArray atIndexes: indexCollection [
	indexCollection
		do: [:index | self assert: (anArray at: index) hasEmptyAssignments]
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> emptyInterface: anArray atIndexes: indexCollection [
	indexCollection
		do: [:index | self assert: (anArray at: index) hasEmptyInterface]
]

{ #category : 'auxiliary' }
InstvarInterfaceExtractorTest >> processMethod: aCompiledMethod [

	| collector |
	collector := TypeCollector onClass: self class.
	collector currentExtractedMethod: aCompiledMethod.
	TypeCollector new newExtractor
		extractInterfacesFrom: aCompiledMethod
		addTo: collector.
	^collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testArithmetic [
	"self run: #testArithmetic"

	| collector |
	collector := self
		doForSource:
			'u := v \\ 3. a := b floor. b := c truncateTo: (x := 4 roundTo: 5)'.
	self
		assertSends: #(#(#v #(#\\)) #(#b #(#floor)) #(#c #(#truncateTo:)))
		in: collector.
	self
		assertAssignments:
			#(#(#u #(#Number)) #(#a #(#Number)) #(#b #(#Number)) #(#x #(#Number)))
		in: collector
]

{ #category : 'tests - combined' }
InstvarInterfaceExtractorTest >> testArithmeticValueSpecialisation [
	| collector |
	collector := self
		doForSource:
			'
		b := (Point x: 2 y: 4) - (1@1) '.
	self
		assertSends: #()
		in: collector.
	self
		assertAssignments: #(#(#b #(#Point)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testArrayAssignment [
	| collector |
	collector := self doForSource: 'v := #(one two three)'.
	self
		assertAssignments: #(#(#v #(#Array)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testBlockReturnValue [

	| collector |
	collector := self doForSource: 'u do: [
				| t1 t2 |
				t2 := #().
				t2 , {42. 43} ]'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testBlockWithCopiedTmp [

	| collector |
	collector := self doForSource: '
		w do: [ :t1 :t2 | t1 do: [ t1 + 1. t2 + 1 ] ]'.
	self assertSends: #( #( #w #( #do: ) ) ) in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testBlockWithWhile [

	| collector |
	collector := self doForSource: '[
		| t1 t2 |
		t2 or: [ t1 ] ]'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testBlocksNested [

	| collector |
	collector := self doForSource: '| k |
	k do: [ :l |
		l do: [ :m |
			k add: l.
			u ~= k ifTrue: [ m remove: k ].
			 ] ]'.

	self assertSends: #( #( #u #( #'~=' ) ) ) in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testCascaded1 [
	| collector |
	collector := self doForSource: 'x printString; size'.
	self
		assertSends: #(#(#x #(#printString #size)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testCascaded2 [
	| collector |
	collector := self doForSource: 'x printString; size; yourself'.
	self
		assertSends: #(#(#x #(#printString #size #yourself)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testComplicated1 [
	| collector |
	collector := self
		doForSource:
			'
		b := Set new: 3 * (c collect: [:s | s])'.
	self
		assertSends: #(#(#c #(#collect:)))
		in: collector.
	self
		assertAssignments: #(#(#b #(#Set)))
		in: collector
]

{ #category : 'non supported' }
InstvarInterfaceExtractorTest >> testComplicated2 [
	| collector |
	collector := self
		doForSource:
			'
		| temp1 temp2 |
		temp1 := b := temp2 := 3.'.
	self
		denyAssignments: #(#(#b #(#SmallInteger)))
		in: collector
]

{ #category : 'non supported' }
InstvarInterfaceExtractorTest >> testComplicated3 [
	"self run: #testComplicated3"
	"self debug: #testComplicated3"

	| collector |
	collector := self
		doForSource:
			'
		| temp1 temp2 temp3 |
		temp2 := b := temp1 := 3.'.
	self
		denyAssignments: #(#(#b #(#SmallInteger)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testEquality [
	| collector |
	collector := self doForSource: 'u := v = 3'.
	self
		assertSends: #(#(#v #(#=)))
		in: collector.
	self
		assertAssignments: #(#(#u #(#Boolean)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testIdentity [
	| collector |
	collector := self doForSource: 'u := v == 3'.
	self
		assertSends: #(#(#v #(#==)))
		in: collector.
	self
		assertAssignments: #(#(#u #(#Boolean)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testIftrue [
	| vSends collector |
	collector := self doForSource: 'u := v isNil ifTrue: [1] ifFalse: [2]'.
	vSends := collector sendsTo: #v.
	self assert: vSends size equals: 1.
	self assert: (vSends includes: #isNil)
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testIndirectAssignments [
	
	(TypeCollector typeInstvar: #c ofClass: ASampleClass) types
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testInstanceAssignment [
	| collector |
	collector := self doForSource: 'w := TypeCollector new'.
	self
		assertAssignments: #(#(#w #(#TypeCollector)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testInstanceAssignmentIndirect [
	| collector |
	collector := self doForSource: 'self w: TypeCollector new'.
	self
		assertAssignments: #(#(#w #(#TypeCollector)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testInstvarAssignment1 [
	| collector |
	collector := self
		doForSource:
			'
		| temp1 temp2 temp3 |
		a := 3.
		b := a'.
	self
		assertAssignments: #(#(#b #(#SmallInteger)) #(#a #(#SmallInteger)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testInstvarAssignment2 [
	| collector |
	collector := self
		doForSource:
			'
		| temp1 temp2 temp3 |
		c := b := 3.'.
	self
		assertAssignments: #(#(#b #(#SmallInteger)) #(#c #(#SmallInteger)))
		in: collector
]

{ #category : 'tests - assignments' }
InstvarInterfaceExtractorTest >> testMetaClassAssignment [
	| collector wAssignments wIndex wIndexRelative |
	collector := self doForSource: 'w := TypeCollector'.
	wIndex := collector absoluteIndexForVar: #w.	"Absolute"
	wIndexRelative := wIndex
		- (self class allInstVarNames size - self class instVarNames size).
	wAssignments := collector assignmentsTo: #w.
	self assert: wAssignments size equals: 1.
	self assert: (wAssignments includes: TypeCollector class).
	self
		emptyAssigment: collector typingResults
		atIndexes:
			(((1 to: self class instVarNames size) asOrderedCollection)
				remove: wIndexRelative;
				yourself)
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testSelfSendWithAssignedTemp [
	| collector |
	collector := self
		doForSource:
			'^ 1 do: [ :m | 2 do: [ :n | 
					u := m.
					self add1To: m.
				] ]'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testSelfSendWithInstVar [
	| collector |
	self flag: 'should it not find out about sending #+ to var u?'.
	collector := self
		doForSource:
			'^ 1 do: [ :m | 2 do: [ :n | 
					self add1To: u.
				] ]'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testSelfSendWithTemp [
	| collector |
	
	collector := self
		doForSource:
			'^ 1 do: [ :m | 2 do: [ :n | 
					self add1To: m.
				] ]'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testSuperivarAssignment [
	| collector |
	collector := self doForSource: '^testSelector := testSelector'.
	self
		assertSends: #()
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testSuperivarSend [
	| collector |
	collector := self doForSource: '^testSelector printString'.
	self
		assertSends: #(#(#testSelector #(#printString)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testThisProcess [

	| collector |
	collector := self doForSource: 'u := thisProcess'.
	self assertSends: #() in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testblockindirectxy [
	| collector |
	collector := self
		doForSource: '^self testu ifTrue: [self x] ifFalse: [self y asString]'.
	self
		assertSends: #(#(#y #(#asString)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testblockuwx [
	| collector |
	collector := self
		doForSource: '^[u + w] on: Error do: [:exc | x printString]'.
	self
		assertSends: #(#(#u #(#+)) #(#x #(#printString)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testblockwithargs [
	| collector |
	collector := self
		doForSource: '^[:s | s + 1] value: 1'.
	self
		assertSends: #()
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testblockxy [
	| collector |
	collector := self doForSource: '^self xyw ifTrue: [x] ifFalse: [y]'.
	self
		assertSends: #()
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testblockyab [
	" #'ifTrue:ifFalse: is sent to a, but is not Captured by the extractor"

	| collector |
	collector := self doForSource: '^self a ifTrue: [b] ifFalse: [y]'.
	self
		assertSends: #()
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testindirectx [
	| collector |
	collector := self doForSource: '^self x printString'.
	self
		assertSends: #(#(#x #(#printString)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testu [
	| collector |
	collector := self doForSource: '^u'.
	self
		assertSends: #()
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testuxyw [
	| collector |
	collector := self
		doForSource: '	u := (x asString ~= y printString). ^u = w'.
	self
		assertSends: #(#(#y #(#printString)) #(#x #(#asString)) #(#u #(#=)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testxyw [
	| collector |
	collector := self
		doForSource:
			'
		| t |
		t := (x = y).
		^t = w'.
	self
		assertSends: #(#(#x #(#=)))
		in: collector
]

{ #category : 'tests - message sends' }
InstvarInterfaceExtractorTest >> testzuv [
	| collector |
	collector := self doForSource: '^u ~= z or: [u = v]'.
	self
		assertSends: #(#(#u #(#= #~=)))
		in: collector
]
