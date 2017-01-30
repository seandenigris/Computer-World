as yet unclassified
onlineFileAt: aUrlOfString

	^ onlineFiles
		detect: [ :f | f = (CwOnlineFile at: aUrlOfString asUrl) ]
		ifNone: [ onlineFiles add: (CwOnlineFile at: aUrlOfString asUrl) ].