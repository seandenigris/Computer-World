as yet unclassified
testLearnAboutSoftware

	| cw |
	cw := ComputerWorld new.
	cw softwareNamed: '1Password'.
	cw software should include: (CwSoftware named: '1Password').