printing
printOn: aStream

	aStream
		nextPutAll: 'Debian key ';
		nextPutAll: id;
		nextPutAll: ' fingerprint = ', fingerprint.