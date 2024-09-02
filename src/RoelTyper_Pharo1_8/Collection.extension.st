Extension { #name : 'Collection' }

{ #category : '*RoelTyper_Pharo1_8' }
Collection >> withIndexDo: elementAndIndexBlock [
	"Just like do: except that the iteration index supplies the second argument to the block"
	"Support collection enumeration with a counter, even though not ordered"

	"|s|s:=0. #(4 2 1) withIndexDo: [:e :i| s:=s + (e * (10 ** (i-1)))]. s >>> 124"

	"|a|a:= Array new: 3. #(10 20 30) withIndexDo: [:e :i| a at: 4-i put: e+1]. a >>> #(31 21 11)"

	| index |
	index := 0.
	self do: [:item | elementAndIndexBlock value: item value: (index := index+1)]
]
