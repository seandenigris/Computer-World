as yet unclassified
removeAllMetadataFrom: file

	| command exitCode |
	command := 'exiftool -all= "', file fullName, '"'.
	exitCode := NBMacShell run: command.
	exitCode = 0 ifFalse: [ self error: 'exiftool failed to remove metadata' ].