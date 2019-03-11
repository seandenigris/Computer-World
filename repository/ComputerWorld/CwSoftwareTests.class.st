Class {
	#name : #CwSoftwareTests,
	#superclass : #TestCase,
	#category : 'ComputerWorld-Specification'
}

{ #category : #'as yet unclassified' }
CwSoftwareTests >> testDownloadUrlShouldAcceptStrings [

	| software address |
	software := CwSoftware named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software 	canBeDownloadedAt: address.

	software downloadUrl should beKindOf: ZnUrl. 
	software downloadUrl asString should = address.
]

{ #category : #'as yet unclassified' }
CwSoftwareTests >> testDownloadUrlShouldAcceptUrls [

	| software address |
	software := CwSoftware named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software 	canBeDownloadedAt: address asUrl.

	software downloadUrl should beKindOf: ZnUrl. 
	software downloadUrl asString should = address.
]

{ #category : #'as yet unclassified' }
CwSoftwareTests >> testPrinting [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software printString should = 'UIBrowser'.
]

{ #category : #'as yet unclassified' }
CwSoftwareTests >> testWebpageShouldAcceptStrings [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html'.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.
]

{ #category : #'as yet unclassified' }
CwSoftwareTests >> testWebpageShouldAcceptUrls [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html' asUrl.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.
]
