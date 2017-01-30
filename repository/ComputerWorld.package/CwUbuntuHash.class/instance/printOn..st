printing
printOn: aStream

	aStream
		nextPutAll: 'md5(';
		nextPutAll: filename;
		nextPutAll: ') = ';
		nextPutAll: md5.