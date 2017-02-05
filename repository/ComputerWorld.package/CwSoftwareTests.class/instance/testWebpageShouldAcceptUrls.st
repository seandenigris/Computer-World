as yet unclassified
testWebpageShouldAcceptUrls

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html' asUrl.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.