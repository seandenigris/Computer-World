Class {
	#name : #CwMacMail,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwMacMail class >> browseSignatures [
	<script>
	self new signatures inspect
]

{ #category : #accessing }
CwMacMail class >> bundleBasename [
	^ 'Mail.app'
]

{ #category : #utilities }
CwMacMail class >> openAllICloudSignatureFiles [
	"most important step from http://matt.coneybeare.me/how-to-make-an-html-signature-in-apple-mail-for-mojave-os-x-10-dot-14/"
	LibC system: 'open -a TextEdit ~/Library/Mobile\ Documents/com\~apple\~mail/Data/V4/Signatures/*.mailsignature'
]

{ #category : #accessing }
CwMacMail class >> signatureFolder [

	| libraryMailFolder vFolders |
	self flag: 'Only works if not using iCloud for Mail. See http://matt.coneybeare.me/how-to-make-an-html-signature-in-apple-mail-for-mojave-os-x-10-dot-14/ for details'.
	libraryMailFolder := FileLocator home / 'Library' / 'Mail'.
	vFolders := libraryMailFolder directoriesMatching: 'V*'.
	self assert: vFolders size = 1. "Domain assumption"
	^ vFolders first / 'MailData' / 'Signatures'
]

{ #category : #'as yet unclassified' }
CwMacMail >> applescriptFolder [

	self flag: 'copy pasted from CwOutlookMac'.
	^ self class package peIceRepository repositoryDirectory / 'applescript'
]

{ #category : #'as yet unclassified' }
CwMacMail >> importMailboxAt: aFileReference [
	"aFileReference - a post-Panther or pre-Tiger mailbox. See `importUnixMbox: comment for more information or send that message to pass a real Unix mbox"

	self tellApplicationTo: 'import Mail mailbox at POSIX file ', aFileReference fullName surroundedByDoubleQuotes
]

{ #category : #'as yet unclassified' }
CwMacMail >> importUnixMbox: aFileReference [
	
	| preTigerMbox |
	preTigerMbox := Tempfile withExtension: 'mbox'.
	preTigerMbox ensureCreateDirectory.
	aFileReference copyTo: preTigerMbox / 'mbox'.
	
	self importMailboxAt: preTigerMbox.

	"Apparently, `import Mail mailbox` can't accept a real Unix mbox (it fails silently), but instead needs a post-Panther or pre-Tiger mailbox. Pre-tiger is easy to create because it's an ordinary directory with an mbox extension, and then the real (i.e. Unix) mbox is a file inside it named 'mbox'
	
	Reference: https://lists.apple.com/archives/applescript-users/2010/May/msg00287.html"
]

{ #category : #accessing }
CwMacMail >> newMessageTo: nameString at: addressString re: subjectString asFollows: contentString [
	
	| template |
	template := 'set newMessage to make new outgoing message with properties \{subject:"{subject}", content:"{content}"\}
    tell newMessage
        set visible to true
        make new to recipient at end of to recipients with properties \{name:"{recipientName}", address:"{recipientAddress}"\}
    end tell
    activate'.
    "Script adapted from https://stackoverflow.com/q/9209385"

	Applescript new
		targetApplication: 'Mail';
		template: template;
		argumentAt: #subject put: subjectString;
		argumentAt: #content put: contentString;
		argumentAt: #recipientName put: nameString;
		argumentAt: #recipientAddress put: addressString;
		run.
]

{ #category : #'as yet unclassified' }
CwMacMail >> selectedMessagesArchive [

	| archiveScript |
	archiveScript := self applescriptFolder / 'mail_app_archive_selection.applescript'.
	LibC system: 'osascript ', archiveScript fullName surroundedByDoubleQuotes
]

{ #category : #'as yet unclassified' }
CwMacMail >> selectedMessagesExport [

	| folder files exportScript |
	self flag: 'copy pasted from CwOutlookMac'.
	
	folder := Tempfile new.
	exportScript := self applescriptFolder / 'mail_app_export_selection.applescript'.
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
CwMacMail >> selectedMessagesImport [

	| messages |
	messages := self selectedMessagesExport.
	messages do: [ :msg | msg import ].
	self selectedMessagesArchive.
	^ messages
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
