Class {
	#name : #CwOutlookMac,
	#superclass : #CwMacApplication,
	#classVars : [
		'ArchiveAccount'
	],
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwOutlookMac class >> archiveAccount [
	^ ArchiveAccount
]

{ #category : #accessing }
CwOutlookMac class >> archiveAccount: anObject [
	"anObject - the user name of an exchange account. For delegated accounts (i.e. shared mailboxes), the user name is just the part of the email address before the @"
	ArchiveAccount := anObject
]

{ #category : #accessing }
CwOutlookMac class >> bundleBasename [
	^ 'Outlook.app'
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> applescriptFolder [
	^ self class package peIceRepository repositoryDirectory / 'applescript'
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> archiveSelectedMessages [
	
	self archiveSelectedMessagesToAccount: self class archiveAccount.
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> archiveSelectedMessagesToAccount: aString [

	| archiveScript |
	archiveScript := self applescriptFolder / 'outlook_archive_selection.applescript'.
	LibC system: 'osascript ', archiveScript fullName surroundedByDoubleQuotes, ' ', aString surroundedByDoubleQuotes
]

{ #category : #'as yet unclassified' }
CwOutlookMac >> selectedMessagesExport [
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

{ #category : #'as yet unclassified' }
CwOutlookMac >> selectedMessagesImport [

	| messages |
	messages := self selectedMessagesExport.
	messages do: [ :msg | msg import ].
	self archiveSelectedMessages.
	^ messages
]
