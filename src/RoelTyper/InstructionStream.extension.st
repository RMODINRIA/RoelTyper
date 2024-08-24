Extension { #name : #InstructionStream }

{ #category : #'*RoelTyper' }
InstructionStream >> printOn: aStream [

	super printOn: aStream.

	aStream
		nextPutAll: ' (';
		nextPutAll: pc asString;
		nextPut: $)
]
