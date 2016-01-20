as yet unclassified
printOn: aStream

	aStream
		nextPutAll: 'Field ';
		nextPutAll: self name surroundedBySingleQuotes;
		nextPutAll: ' = ';
		nextPutAll: self value surroundedBySingleQuotes.