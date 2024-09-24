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
	folder := Tempfile new ensureCreateDirectory.
	exportScript := self applescriptFolder / 'outlook_export_emails.applescript'.
	LibC
		system: 'osascript ' , exportScript fullName surroundedByDoubleQuotes , ' '
				, folder fullName surroundedByDoubleQuotes.
	files := folder filesMatching: '*.eml'.
	^ files collect: [ :file | file asRlResource ]
]
