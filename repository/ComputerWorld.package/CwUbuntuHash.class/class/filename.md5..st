instance creation
filename: filename md5: hashString 

	^ self new
		filename: filename;
		md5: hashString;
		yourself.