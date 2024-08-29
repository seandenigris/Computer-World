Class {
	#name : #CwSoftwareTests,
	#superclass : #TestCase,
	#category : #'ComputerWorld-Specification'
}

{ #category : #accessing }
CwSoftwareTests >> testDownloadUrlShouldAcceptStrings [

	| software address |
	software := CwSoftware named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software downloadUrl: address.

	software downloadUrl should beKindOf: ZnUrl. 
	software downloadUrl asString should equal: address.
]

{ #category : #accessing }
CwSoftwareTests >> testDownloadUrlShouldAcceptUrls [

	| software address |
	software := CwSoftware named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software downloadUrl: address asUrl.

	software downloadUrl should beKindOf: ZnUrl. 
	software downloadUrl asString should equal: address.
]

{ #category : #accessing }
CwSoftwareTests >> testPrinting [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software printString should equal: 'UIBrowser'.
]

{ #category : #accessing }
CwSoftwareTests >> testWebpageShouldAcceptStrings [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html'.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should equal: 'http://pfiddlesoft.com/uibrowser/index.html'.
]

{ #category : #accessing }
CwSoftwareTests >> testWebpageShouldAcceptUrls [

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html' asUrl.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should equal: 'http://pfiddlesoft.com/uibrowser/index.html'.
]
