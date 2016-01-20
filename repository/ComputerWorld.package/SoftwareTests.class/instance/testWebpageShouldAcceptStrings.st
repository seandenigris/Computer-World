as yet unclassified
testWebpageShouldAcceptStrings

	| software |
	software := Software named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html'.
	software webpage should beKindOf: HttpUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.