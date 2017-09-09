printing
printOn: aStream

	aStream
		nextPutAll: name;
		nextPutAll: ' mail sig (';
		nextPutAll: id;
		nextPut: $)