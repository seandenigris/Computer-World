as yet unclassified
testPrinting

	| software |
	software := CwSoftware named: 'UIBrowser'.
	
	software printString should = 'UIBrowser'.