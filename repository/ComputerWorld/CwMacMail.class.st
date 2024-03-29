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
