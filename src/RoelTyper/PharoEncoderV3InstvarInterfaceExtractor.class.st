Class {
	#name : 'PharoEncoderV3InstvarInterfaceExtractor',
	#superclass : 'PharoAbstractInstvarInterfaceExtractor',
	#instVars : [
		'blocksLimits'
	],
	#category : 'RoelTyper-Pharo',
	#package : 'RoelTyper',
	#tag : 'Pharo'
}

{ #category : 'instruction decoding' }
PharoEncoderV3InstvarInterfaceExtractor >> blockMappingNotFoundFor: offset [

	^ #blockTemp -> (offset - self blockMapping size)
]

{ #category : 'block' }
PharoEncoderV3InstvarInterfaceExtractor >> blocksArgsBySize [
	^ blocksLimits ifNil: [ blocksLimits := OrderedCollection new ]
]

{ #category : 'block' }
PharoEncoderV3InstvarInterfaceExtractor >> blocksDecrement [

	blocksLimits := blocksLimits select: [ :e |
		                e = input pc
			                ifTrue: [
				                self removeBlockMapping.
				                false ]
			                ifFalse: [ true ] ]
]

{ #category : 'extracting' }
PharoEncoderV3InstvarInterfaceExtractor >> extractInterfacesFrom: m addTo: aTypeCollector [

	blocksLimits := OrderedCollection new.
	^ super extractInterfacesFrom: m addTo: aTypeCollector
]

{ #category : 'testing' }
PharoEncoderV3InstvarInterfaceExtractor >> isTempKey: aSymbol [

	^ aSymbol = #temp
]

{ #category : 'instruction decoding' }
PharoEncoderV3InstvarInterfaceExtractor >> popIntoTemporaryVariable: offset [
	"Remove Top Of Stack And Store Into Temporary Variable bytecode."

	self inABlock ifTrue: [
		^ self "unable to determine position of block temps amongst entire method vars" ].
	super popIntoTemporaryVariable: offset
]

{ #category : 'instruction decoding' }
PharoEncoderV3InstvarInterfaceExtractor >> pushClosureCopyNumCopiedValues: numCopied numArgs: numArgs blockSize: blockSize [

	self newBlockMapping.
	self blocksArgsBySize add: blockSize + input pc - 1.
	1 to: numArgs do: [ :index |
	self blockMapping add: #blockArg -> index ].
	numCopied timesRepeat: [
		self blockMapping add: stack removeLast afterIndex: numArgs ].
	stack addLast: #block.
	blockArgs := numArgs
]

{ #category : 'instruction decoding' }
PharoEncoderV3InstvarInterfaceExtractor >> storeIntoTemporaryVariable: offset [
	"Store Top Of Stack Into Temporary Variable Of Method bytecode."

	stack ifEmpty: [ ^ self ].
	super storeIntoTemporaryVariable: offset
]

{ #category : 'instruction decoding' }
PharoEncoderV3InstvarInterfaceExtractor >> tempOffsetFrom: offset [

	^ offset
]
