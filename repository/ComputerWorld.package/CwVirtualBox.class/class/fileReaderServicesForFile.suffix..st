as yet unclassified
fileReaderServicesForFile: fullName suffix: suffix
	<fileService>

	^(#('vbox' 'vbox-extpack') includes: suffix)
		ifTrue: [ { self serviceVerify } ]
		ifFalse: [#()]
