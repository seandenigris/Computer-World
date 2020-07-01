Class {
	#name : #CwQNAP,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwQNAP class >> downloadsForModel: aString [
	"CwQNAP downloadsForModel: 'tvs-472xt' >>> self"
	| url |
	url := 'https://www.qnap.com/en/download?category=firmware' asUrl
		queryAt: 'model' put: aString;
		yourself.
		
	Smalltalk tools webBrowser new open: url
]
