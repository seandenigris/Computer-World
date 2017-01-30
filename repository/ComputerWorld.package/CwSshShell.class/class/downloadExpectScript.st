private
downloadExpectScript

	| response |
	response := ZnEasy get: 'https://gist.github.com/seandenigris/4945436/raw'.
	response isSuccess ifFalse: [ self error: 'Could not download expect script. Got ', response asString ].
	FileStream fileNamed: self expectFileReference do: [ :file | file nextPutAll: response contents ].