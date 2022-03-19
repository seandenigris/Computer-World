Class {
	#name : #CwExifTool,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwExifTool class >> url [

	^ 'http://www.sno.phy.queensu.ca/~phil/exiftool/' asUrl.
]

{ #category : #accessing }
CwExifTool >> removeAllMetadataFrom: file [

	'exiftool -all= {file}' asSuCommand
		argumentAt: file put: file;
		run
]

{ #category : #accessing }
CwExifTool >> restoreSafeMetadataTo: file [

	| command backupFile |
	backupFile := file parent / file base, (file extension, '_original').
	
	command := 'exiftool -overwrite_original -tagsfromfile "{backupFile}" -exposuretime -aperturevalue -flash -iso -lens -focallength -orientation -datetimeoriginal "{file}"' asSuCommand.
	
	command
		argumentAt: #backupFile put: backupFile;
		argumentAt: #file put: file;
		run
]

{ #category : #'as yet unclassified' }
CwExifTool >> scrubMetadataFrom: file [

	self removeAllMetadataFrom: file.
	self restoreSafeMetadataTo: file.
]
