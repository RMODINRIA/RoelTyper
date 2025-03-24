Class {
	#name : 'ASampleClass',
	#superclass : 'Object',
	#instVars : [
		'a',
		'b',
		'c',
		'd',
		'e',
		'f',
		'g'
	],
	#category : 'RoelTyper-Tests-TestData',
	#package : 'RoelTyper-Tests',
	#tag : 'TestData'
}

{ #category : 'assignments links' }
ASampleClass >> a [
	a := 5
]

{ #category : 'assignments links' }
ASampleClass >> b [
	b := a
]

{ #category : 'blocks typing' }
ASampleClass >> blockReturn: arg [
	"(TypeCollector typeTmpsIn: (self>>#blockReturn:) ofClass: self) "
	
	self byParam: [:bu | ^bu].
	g := arg.
	
]

{ #category : 'parameters links' }
ASampleClass >> byParam [
	e := 6.
	self byParam: e
]

{ #category : 'parameters links' }
ASampleClass >> byParam: aTmp [ 
	d := aTmp
]

{ #category : 'assignments links' }
ASampleClass >> c [
	c := b
]

{ #category : 'blocks typing' }
ASampleClass >> inlinedBlocks [

	| t1 t2 t3 |
	t1 := 1.
	t2 ifNotNil: [ :t4 |
		| t5 t6 |
		t5 := 't5'.
		t6 := 1.2.
		t4 > 5.
		Array new do: [ :t7 |
			| t8 |
			t7 asInteger.
			t7 ifNil: [ t8 asString ].
			Array new withIndexDo: [ :t9 :t10 |
				| t11 t12 |
				t11 := $1.
				t12 := #t12.
				t6 * t6.
				t9 , t10 ] ] ].
	t3 := #(  ).
	^ Set new
]

{ #category : 'temporaries typing' }
ASampleClass >> nestedBlocksComplex: mArg [

	| mTemp1 mTemp2 mTemp3 |
	mArg asArray.
	mTemp1 := 11.
	mTemp1 ifNotNil: [ :b1Arg |
		| b1Temp |
		b1Arg isInfix.
		b1Temp := '5'.
		b1Temp capitalized ].
	mTemp1 lastDigit > 0
		ifTrue: [
			| b2Temp1Shadowed b2Temp2 |
			b2Temp2 := [ :b2b1Arg |
			           | b2b1Temp b2Temp1Shadowed |
			           b2Temp1Shadowed := 8.0.
			           b2Temp1Shadowed asMinimalDecimalFraction.
			           mTemp2 := 33333333333333333333333333333333.
			           mTemp2 primeFactors.
			           mTemp1 + 1.
			           mTemp3 - 1.
			           b2b1Temp := Set new ].
			b2Temp2 value.
			b2Temp1Shadowed := $5.
			b2Temp1Shadowed digitValue ]
		ifFalse: [ self nestedBlocksComplex: #(  ) ].
	mTemp2 noMask: 3
]

{ #category : 'blocks typing' }
ASampleClass >> nestedBlocksUsingOuterTemps [

	| ta1 ta2 ta3 ta4 |
	ta2 := 'ta2'.
	ta4 := [
	       | tb1 tb2 tb3 tb4 |
	       tb4 := Date today.
	       tb1 := [
	              | tc1 |
	              tc1 := 1.
	              ta3 := 1.0.
	              tb3 := $2 ].
	       tb1 value ].
	ta4 value
]

{ #category : 'blocks typing' }
ASampleClass >> nestedBlocksWithTemps [

	| t1 |
	t1 := [
	      | t2 t3 |
	      t2 := 1.
	      t3 := [
	            | t4 |
	            t4 := 4.0 ] ]
]

{ #category : 'return links' }
ASampleClass >> primitive [

	<primitive: 70 error: tmpPrimitive>
	| tmpRegular |
	tmpRegular := 1.0
]

{ #category : 'return links' }
ASampleClass >> return [
	"(TypeCollector typeTmpsIn: (self>>#return) ofClass: self)"
	^5
]

{ #category : 'return links' }
ASampleClass >> streamContents [

	| array string |
	array := #(  ).
	array isEmpty ifTrue: [ ^ self ].
	string := String streamContents: [ :stream |
		          array
			          do: [ :each | each writeNameAndValueOn: stream ]
			          separatedBy: [ stream nextPutAll: '; ' ] ].
	^ string
]

{ #category : 'return links' }
ASampleClass >> useReturn [
	"(TypeCollector typeInstvar: #f ofClass: self) types"
	^f := self return.
]
