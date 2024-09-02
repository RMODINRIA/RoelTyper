Class {
	#name : 'PharoEncoderSistaV1InstvarInterfaceExtractor',
	#superclass : 'PharoAbstractInstvarInterfaceExtractor',
	#instVars : [
		'tempVarAmount'
	],
	#category : 'RoelTyper-Pharo',
	#package : 'RoelTyper',
	#tag : 'Pharo'
}

{ #category : 'extracting' }
PharoEncoderSistaV1InstvarInterfaceExtractor >> extractInterfacesFrom: m addTo: aTypeCollector [

	tempVarAmount := m numTemps.
	^ super extractInterfacesFrom: m addTo: aTypeCollector
]

{ #category : 'instruction decoding' }
PharoEncoderSistaV1InstvarInterfaceExtractor >> popIntoRemoteTemp: remoteTempIndex inVectorAt: tempVectorIndex [
	"Remove Top Of Stack And Store Into Offset of Temp Vector bytecode."

	| methodLevelOffset rvalue |
	rvalue := super
		          popIntoRemoteTemp: remoteTempIndex
		          inVectorAt: tempVectorIndex.
	methodLevelOffset := self tempOffsetFrom: tempVectorIndex.
	collector handleAssignment: rvalue forTmp: methodLevelOffset
]

{ #category : 'instruction decoding' }
PharoEncoderSistaV1InstvarInterfaceExtractor >> pushFullClosure: compiledBlock numCopied: numCopied receiverOnStack: onStack ignoreOuterContext: ignore [

	| originalInput |
	self newBlockMapping.
	originalInput := input.
	input := InstructionStream on: compiledBlock.
	tempVarAmount to: tempVarAmount + compiledBlock numArgs - 1 do: [
	:index | self blockMapping add: #blockArg -> index ].
	numCopied timesRepeat: [
		self blockMapping
			add: stack removeLast
			afterIndex: compiledBlock numArgs ].
	tempVarAmount + compiledBlock numArgs to:
	tempVarAmount + compiledBlock numTemps - numCopied - 1 do: [ :index |
	self blockMapping add: #blockTemp -> index ].
	tempVarAmount := tempVarAmount + compiledBlock numTemps - numCopied.
	stack addLast: #block.
	[ input atEnd ] whileFalse: [
		self reloadStack.
		input interpretNextInstructionFor: self ].
	input := originalInput.
	self removeBlockMapping
]

{ #category : 'instruction decoding' }
PharoEncoderSistaV1InstvarInterfaceExtractor >> storeIntoRemoteTemp: remoteTempIndex inVectorAt: tempVectorIndex [
	"Pharo 9+
	 Store Top Of Stack And Store Into Offset of Temp Vector bytecode."

	| methodLevelOffset rvalue |
	methodLevelOffset := self tempOffsetFrom: tempVectorIndex.
	rvalue := stack removeLast.
	collector handleAssignment: rvalue forTmp: methodLevelOffset.
	stack add: rvalue
]
