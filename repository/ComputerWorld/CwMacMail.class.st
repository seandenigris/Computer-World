Class {
	#name : #CwMacMail,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwMacMail class >> browseSignatures [
	<script>
	self new signatures inspect
]

{ #category : #accessing }
CwMacMail >> signatureFolder [

	| libraryMailFolder vFolders |
	self flag: 'Only works if not using iCloud for Mail. See http://matt.coneybeare.me/how-to-make-an-html-signature-in-apple-mail-for-mojave-os-x-10-dot-14/ for details'.
	libraryMailFolder := FileLocator home / 'Library' / 'Mail'.
	vFolders := libraryMailFolder directoriesMatching: 'V*'.
	self assert: vFolders size = 1. "Domain assumption"
	^ vFolders first / 'MailData' / 'Signatures'
]

{ #category : #'as yet unclassified' }
CwMacMail >> signatureList [

	| signatureListFile doc |
	signatureListFile := self signatureFolder / 'AllSignatures.plist'.
	doc := XMLDOMParser parse: signatureListFile contents.
	^ doc allElementsNamed: #dict.
]

{ #category : #'as yet unclassified' }
CwMacMail >> signatures [

	^ self signatureList collect: [ :e | CwMacMailSignature fromXML: e ] as: OrderedCollection
]
