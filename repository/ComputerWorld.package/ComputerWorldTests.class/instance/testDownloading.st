as yet unclassified
testDownloading

	| cw software |
	cw := ComputerWorld new.
	software := cw softwareNamed: '1Password'.
"	software downloadFrom: 'http://agilebits.com/downloads/1Password/Mac' asUrl."
	self flag: #pending.