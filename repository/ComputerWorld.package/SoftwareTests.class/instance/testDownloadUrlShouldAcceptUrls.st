as yet unclassified
testDownloadUrlShouldAcceptUrls

	| software address |
	software := Software named: 'UIBrowser'.
	address := 'http://pfiddlesoft.com/uibrowser/downloads/UIBrowser211.dmg'.
	
	software 	canBeDownloadedAt: address asUrl.

	software downloadUrl should beKindOf: HttpUrl. 
	software downloadUrl asString should = address.