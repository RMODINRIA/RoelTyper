"
(TypeCollector typeTmpsIn: (ASampleClass>>#return) ofClass: ASampleClass)
"
Class {
	#name : 'PharoTypeCollector',
	#superclass : 'TypeCollector',
	#category : 'RoelTyper-Pharo',
	#package : 'RoelTyper',
	#tag : 'Pharo'
}

{ #category : 'utilities' }
PharoTypeCollector class >> ownTempNamesForBlockNode: aBlockNode [
	"this method is called from RB/ASTBlockNode and would be better suited as an extension method there, but it got renamed over time so this same code would need to be duplicated for each class name that existed, making maintainability actually worse"

	| tempNamesBySource tempNames |
	tempNamesBySource := {
		                     aBlockNode argumentNames.
		                     (aBlockNode scope tempVars values
			                      reject: [ :each | each isArgumentVariable ]
			                      thenCollect: [ :each | each name ]).

		                     (aBlockNode scope tempVector
			                      collect: [ :each | each name ]
			                      as: Array) }.
	aBlockNode isInlined ifTrue: [
		tempNamesBySource := tempNamesBySource reversed ].
	tempNames := OrderedCollection new.
	tempNamesBySource do: [ :eachSourceTemps |
		eachSourceTemps do: [ :eachTemp |
			tempNames addIfNotPresent: eachTemp ] ].
	^ tempNames
]

{ #category : 'heuristics' }
PharoTypeCollector >> assignmentTypeOf: val [

	val isBehavior ifTrue: [ ^ val ].
	val isVariableBinding ifTrue: [
		^ val key == #instcreation
			  ifTrue: [ val value ]
			  ifFalse: [ val value class ] ].
	val == #block ifTrue: [ ^ BlockClosure ].
	^ nil
]

{ #category : 'heuristics' }
PharoTypeCollector >> languageSpecificPushSendOf: selector to: rec args: args [
	(#(#// #quo: #rem: #\\ #ceiling #floor #rounded #roundTo: #truncated #truncateTo: #/ #+ #- #* #abs #negated #reciprocal)
		includes: selector)
		ifTrue:
			[^self
				tryUsing: rec
				for: selector
				ifNotUse: Number].
	(selector = #yourself) ifTrue: [^rec].
	(rec = #self and: [(theClass methodDict includesKey: selector)]) ifTrue: [^#return->selector].
	^#computed
]

{ #category : 'private' }
PharoTypeCollector >> newExtractor [

	^ PharoAbstractInstvarInterfaceExtractor forEncoder:
		  self class methods anyOne encoderClass
]
