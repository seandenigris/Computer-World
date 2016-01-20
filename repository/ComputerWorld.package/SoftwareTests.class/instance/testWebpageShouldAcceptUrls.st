as yet unclassified
testWebpageShouldAcceptUrls

	| software |
	software := Software named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html' asUrl.
	software webpage should beKindOf: HttpUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.