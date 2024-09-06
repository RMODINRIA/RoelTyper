"
I am a Pharo-specific version of InstvarInterfaceExtractor, that is responsible for extracting the messages sent to an instance variable and the assignments done to an instance variable. 

I should be compatible with multiple compilers along history of Pharo, making me quite complex and not using all my methods and variables for every version of Pharo.

Additional instance variables:
	blockTempsMapping <SequenceableCollection of: SequenceableCollection of: Symbol -> Integer> maps temps in block to list of all temps, having one inner collection for each nested block
	blocksLimits 
	tempVarAmount <Integer> amount of temporary variables processed so far in the entire method, used for calculating blockTempsMapping

"
Class {
	#name : 'PharoAbstractInstvarInterfaceExtractor',
	#superclass : 'InstvarInterfaceExtractor',
	#instVars : [
		'blockTempsMapping'
	],
	#category : 'RoelTyper-Pharo',
	#package : 'RoelTyper',
	#tag : 'Pharo'
}

{ #category : 'instance creation' }
PharoAbstractInstvarInterfaceExtractor class >> classForEncoder: aBytecodeEncoder [

	(aBytecodeEncoder name includesSubstring: 'Sista') ifTrue: [
		^ PharoEncoderSistaV1InstvarInterfaceExtractor ].
	^ PharoEncoderV3InstvarInterfaceExtractor
]

{ #category : 'instance creation' }
PharoAbstractInstvarInterfaceExtractor class >> forEncoder: aBytecodeEncoder [

	^ (self classForEncoder: aBytecodeEncoder) new
]

{ #category : 'block' }
PharoAbstractInstvarInterfaceExtractor >> blockMapping [
	^ blockTempsMapping last
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> blockMappingNotFoundFor: offset [

	^ self error: 'Could not find temp at offset ' , offset asString
]

{ #category : 'block' }
PharoAbstractInstvarInterfaceExtractor >> blocksDecrement [
	"do nothing"

	
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> callPrimitive: aPrimitive [

	stack add: PrimitiveFailed
]

{ #category : 'extracting' }
PharoAbstractInstvarInterfaceExtractor >> extractInterfacesFrom: m addTo: aTypeCollector [

	method := m.
	saveStacks := Dictionary new.
	stack := OrderedCollection new.
	initialStack := stack copy.
	collector := aTypeCollector.
	input := InstructionStream on: method.
	blockTraversal := false.
	blockTempsMapping := OrderedCollection new.
	blockArgs := 0.
	[ input atEnd ] whileFalse: [
		self reloadStack.
		input interpretNextInstructionFor: self.
		self blocksDecrement ]
]

{ #category : 'block' }
PharoAbstractInstvarInterfaceExtractor >> inABlock [
	^ blockTempsMapping isNotEmpty
]

{ #category : 'initialization' }
PharoAbstractInstvarInterfaceExtractor >> initialize [

	super initialize.
	blockTempsMapping := OrderedCollection new
]

{ #category : 'testing' }
PharoAbstractInstvarInterfaceExtractor >> isTempKey: aSymbol [

	^ (super isTempKey: aSymbol) or: [
		  aSymbol = #blockTemp or: [ aSymbol = #blockArg ] ]
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> methodReturnTop [
	^self pop
]

{ #category : 'block' }
PharoAbstractInstvarInterfaceExtractor >> newBlockMapping [
	blockTempsMapping add: OrderedCollection new.
	
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> popIntoRemoteTemp: remoteTempIndex inVectorAt: tempVectorIndex [
	"Remove Top Of Stack And Store Into Offset of Temp Vector bytecode."

	^ stack removeLast
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> popIntoTemporaryVariable: offset [
	"Remove Top Of Stack And Store Into Temporary Variable bytecode."

	| methodLevelOffset rvalue |
	methodLevelOffset := self tempOffsetFrom: offset.
	rvalue := stack removeLast.
	collector handleAssignment: rvalue forTmp: methodLevelOffset
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> pushActiveProcess [
	
	stack add: #thisProcess
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> pushConsArrayWithElements: anArray [
	stack add: #instcreation -> Array
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> pushNewArrayOfSize: numElements [ 
	"Push New Array of size numElements bytecode."
	stack addLast: #computed 
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> pushRemoteTemp: remoteTempIndex inVectorAt: tempVectorIndex [
	"Pharo 9+
	 Push Contents at Offset in Temp Vector bytecode."

	self inABlock
		ifTrue: [ stack add: (self blockMapping at: tempVectorIndex + 1) ]
		ifFalse: [ stack add: #temp -> tempVectorIndex ]
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> pushTemporaryVariable: offset [
	"Push Contents Of Temporary Variable Whose Index Is the 
	argument, offset, On Top Of Stack bytecode."

	self inABlock
		ifTrue: [
			stack add: (self blockMapping
					 at: offset + 1
					 ifAbsent: [ self blockMappingNotFoundFor: offset ]) ]
		ifFalse: [ stack add: #temp -> offset ]
]

{ #category : 'removing' }
PharoAbstractInstvarInterfaceExtractor >> removeBlockMapping [
	blockTempsMapping removeLast
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> send: selector numArgs: na [

	^ self nativeSend: selector numArgs: na
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> storeIntoTemporaryVariable: offset [
	"Store Top Of Stack Into Temporary Variable Of Method bytecode."

	| methodLevelOffset rvalue |
	methodLevelOffset := self tempOffsetFrom: offset.
	rvalue := stack removeLast.
	collector handleAssignment: rvalue forTmp: methodLevelOffset.
	stack add: rvalue
]

{ #category : 'instruction decoding' }
PharoAbstractInstvarInterfaceExtractor >> tempOffsetFrom: originalOffset [
	"Store Top Of Stack Into Temporary Variable Of Method bytecode."

	self inABlock ifFalse: [ ^ originalOffset ].
	^ (self blockMapping at: originalOffset + 1) value
]
