as yet unclassified
testLearnAboutSoftware

	| cw |
	cw := ComputerWorld new.
	cw softwareNamed: '1Password'.
	cw software should include: (Software named: '1Password').