Class {
	#name : 'CwExifTool',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwExifTool class >> url [

	^ 'http://www.sno.phy.queensu.ca/~phil/exiftool/' asUrl.
]

{ #category : 'as yet unclassified' }
CwExifTool >> removeAllMetadataFrom: file [

	| command exitCode |
	command := 'exiftool -all= "', file fullName, '"'.
	exitCode := NBMacShell run: command.
	exitCode = 0 ifFalse: [ self error: 'exiftool failed to remove metadata' ].
]

{ #category : 'as yet unclassified' }
CwExifTool >> restoreSafeMetadataTo: file [

	| command exitCode backupFile commandTemplate |
	backupFile := file parent / file base, (file extension, '_original').
	commandTemplate := 'exiftool -overwrite_original -tagsfromfile "{1}" -exposuretime -aperturevalue -flash -iso -lens -focallength -orientation -datetimeoriginal "{2}"'.
	command := commandTemplate format: { backupFile fullName. file fullName }.
	exitCode := NBMacShell run: command.
	exitCode = 0 ifFalse: [ self error: 'exiftool failed to restore metadata' ].
]

{ #category : 'as yet unclassified' }
CwExifTool >> scrubMetadataFrom: file [

	self removeAllMetadataFrom: file.
	self restoreSafeMetadataTo: file.
]
