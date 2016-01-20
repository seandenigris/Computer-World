as yet unclassified
at: fieldName put: aString

	| fieldNameParser parser nameLine nameIndex bom valueLine isUtf16 encodedValue |
	bom := String with: 254 asCharacter with: 255 asCharacter.
	fieldNameParser := bom asParser optional.
	fieldName do: [ :char | fieldNameParser := fieldNameParser, Character null asParser optional, char asParser ].
	parser := '/T (' asParser, fieldNameParser, $) asParser end.
	nameLine := lines detect: [ :e | parser matches: e ] ifNone: [ self error: 'Fdf does not contain a ', fieldName, ' field' ].
	nameIndex := lines indexOf: nameLine. 
	valueLine := lines at: nameIndex - 1.
	isUtf16 := valueLine includesSubstring: bom.
	encodedValue := isUtf16
		ifTrue: [ 
			String streamContents: [ :str |
				str
					nextPutAll: '/V (';
					nextPutAll: bom.
				aString do: [ :char |
					str
						nextPut: Character null;
						nextPut: char ].
				str nextPut: $) ] ]
		ifFalse: [ '/V (', aString, ')' ].
	lines at: nameIndex - 1 put: encodedValue.