private
waitForFileToBeginDownloading

	| downloadDirectory wasCreatedAfterPageOpened |
	downloadDirectory := FileDirectory on: '/Users/god/Downloads/'.
	[ downloadingFile isNil ] whileTrue: [
		downloadingFile := downloadDirectory entries
			detect: [ :f | 
				(f wasCreatedAfter: timePageOpened) and: [ f isDownloading ] ]
			ifNone: [ nil ] ].
	
	