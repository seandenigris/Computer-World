as yet unclassified
onlineFileAt: aUrlOfString

	^ onlineFiles
		detect: [ :f | f = (OnlineFile at: aUrlOfString asUrl) ]
		ifNone: [ onlineFiles add: (OnlineFile at: aUrlOfString asUrl) ].