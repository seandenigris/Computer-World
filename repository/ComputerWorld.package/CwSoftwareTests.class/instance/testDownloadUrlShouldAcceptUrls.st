as yet unclassified
testDownloadUrlShouldAcceptUrls

	| software address |
	software := CwSoftware named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software 	canBeDownloadedAt: address asUrl.

	software downloadUrl should beKindOf: ZnUrl. 
	software downloadUrl asString should = address.