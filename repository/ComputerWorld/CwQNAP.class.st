Class {
	#name : #CwQNAP,
	#superclass : #Object,
	#category : #'ComputerWorld-NAS'
}

{ #category : #'as yet unclassified' }
CwQNAP class >> defaultLogin [
	Smalltalk tools webBrowser new open: 'https://www.qnap.com/en/how-to/knowledge-base/article/default-password-of-admin-is-changed-to-first-mac-address-after-qts-4-4-2'
]

{ #category : #'as yet unclassified' }
CwQNAP class >> downloadsForModel: aString [
	"CwQNAP downloadsForModel: 'tvs-472xt' >>> self"
	| url |
	url := 'https://www.qnap.com/en/download?category=firmware' asUrl
		queryAt: 'model' put: aString;
		yourself.
		
	Smalltalk tools webBrowser new open: url
]
