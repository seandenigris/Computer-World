as yet unclassified
testWebpageShouldAcceptStrings

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software webpage: 'http://pfiddlesoft.com/uibrowser/index.html'.
	software webpage should beKindOf: ZnUrl. 
	software webpage asString should = 'http://pfiddlesoft.com/uibrowser/index.html'.