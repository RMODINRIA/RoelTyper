Class {
	#name : 'TypeCollectorTest',
	#superclass : 'RoelTypingTestRoot',
	#category : 'RoelTyper-Tests-Tests',
	#package : 'RoelTyper-Tests',
	#tag : 'Tests'
}

{ #category : 'tests - typing' }
TypeCollectorTest >> methodWithTmpInBlock: anObject [
	|some fancy variables|
	some := 1.
	fancy := 'hola'.
	variables := #sexSymbol.
	[ |l| l := true. l ] whileFalse: [ ].
	^ self
]

{ #category : 'auxiliary' }
TypeCollectorTest >> processMethod: aCompiledMethod [

	| collector |
	collector := TypeCollector onClass: self class.
	collector currentExtractedMethod: aCompiledMethod.
	TypeCollector new newExtractor
		extractInterfacesFrom: aCompiledMethod
		addTo: collector.
	^ collector
]

{ #category : 'tests' }
TypeCollectorTest >> testBlockTempsSmokeTest [
	"tests for problem described in TypeCollector>>#handleAssignment:forTmp:"

	| collector |
	collector := self doForSource: '
	| tmp |
	[ | blocktmp1 blocktmp2 blocktmp3 |
		tmp := 1.
		blocktmp3 := self.
	]
'
]

{ #category : 'tests - typing' }
TypeCollectorTest >> testOnBehavior [

	self shouldnt: (TypeCollector typeInstvar:  #'superclass' ofClassWithLookup: Behavior) raise: Error
]

{ #category : 'tests - typing' }
TypeCollectorTest >> testOnTmpVarContainedInBlock [

	self shouldnt: (TypeCollector typeTmpsIn: (self class >> #methodWithTmpInBlock:)
		ofClass: self class) raise: Error
]

{ #category : 'tests - typing' }
TypeCollectorTest >> testPoint [
	| types xTypes yTypes |
	types := TypeCollector typeInstvarsOfClass: Point.
	xTypes := types at: #x.
	self assert: ((xTypes is: Number) or: [xTypes is: Integer]).
	yTypes := types at: #y.
	self assert: ((yTypes is: Number) or: [yTypes is: Integer])
]

{ #category : 'tests' }
TypeCollectorTest >> testPrimitive [

	| collector tmpAssignments |
	collector := self doForSource: '<primitive: 70 error: tmp>'.
	self
		assertCollection:
		(collector packagedResults asDictionary at: '_gen>>^') assignments
		hasSameElements: { self class }.
	tmpAssignments := (collector packagedResults asDictionary at:
		                   '_gen>>tmp') assignments.
	self assert: tmpAssignments size equals: 1.
	self assert: (tmpAssignments anyOne inheritsFrom: Exception)
]

{ #category : 'tests' }
TypeCollectorTest >> testPrimitiveAndTemp [

	| collector results |
	collector := TypeCollector new.
	results := collector
		           typeTmpsIn: ASampleClass >> #primitive
		           ofClass: ASampleClass.
	self
		assertCollection: results keys
		hasSameElements: #( #'^' #tmpPrimitive #tmpRegular ).
	self
		assertCollection: (results at: #tmpPrimitive) assignments
		hasSameElements: { PrimitiveFailed }.
	self
		assertCollection: (results at: #tmpRegular) assignments
		hasSameElements: { SmallFloat64 }
]
