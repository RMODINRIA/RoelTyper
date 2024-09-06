Class {
	#name : 'RoelTypingTestRoot',
	#superclass : 'TestCase',
	#instVars : [
		'dummyVariable',
		'for',
		'offsetTest'
	],
	#category : 'RoelTyper-Tests-Tests',
	#package : 'RoelTyper-Tests',
	#tag : 'Tests'
}

{ #category : 'testing' }
RoelTypingTestRoot class >> isAbstract [

	^ self = RoelTypingTestRoot
]

{ #category : 'auxiliary' }
RoelTypingTestRoot >> doForSource: src [

	| compiler ast method |
	compiler := Smalltalk compiler.
	compiler
		source: 'gen ' , src;
		class: self mainTestClass;
		requestor: nil;
		failBlock: [
			self error: 'Error during compilation of generated method.' ].
	ast := compiler parse.
	method := ast generateMethodByCompiler: compiler.
	^ self processMethod: method
]

{ #category : 'constants' }
RoelTypingTestRoot >> mainTestClass [

	^ self class
]

{ #category : 'auxiliary' }
RoelTypingTestRoot >> processMethod: aCompiledMethod [
	"Fail by default. Needs to be overridden by subclasses to trigger the base testing backbone."

	self assert: false
]
