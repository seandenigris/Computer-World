Class {
	#name : #CwOutlookMac,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwOutlookMac class >> bundleBasename [
	^ 'Outlook.app'
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> applescriptFolder [
	^ self class package peIceRepository repositoryDirectory / 'applescript'
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> archiveSelectedMessagesToAccount: aString [

	| archiveScript |
	archiveScript := self applescriptFolder / 'outlook_archive_selection.applescript'.
	LibC system: 'osascript ', archiveScript fullName surroundedByDoubleQuotes, ' ', aString surroundedByDoubleQuotes
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> exportSelectedMessages [
	| folder files exportScript |
	folder := Tempfile new.
	exportScript := self applescriptFolder / 'outlook_export_emails.applescript'.
	LibC
		system: 'osascript ' , exportScript fullName surroundedByDoubleQuotes , ' '
				, folder ensureCreateDirectory fullName surroundedByDoubleQuotes.
	files := folder filesMatching: '*.eml'.
	^ files collect: [ :file | 
		| tfile |
		"Copy the eml files elsewhere because the tmp folder will be deleted when no longer referenced - probably as soon as this method returns!"
		tfile := Tempfile named: file basename.
		file copyTo: tfile.
		tfile asRlResource ]
]
