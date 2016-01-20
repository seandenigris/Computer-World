as yet unclassified
at: keySymbol

	| tmpFile commandTemplate command output |
	tmpFile := ('tmp', DateAndTime now printString asLegalSelector, '.txt') asFileReference.
	commandTemplate := 'defaults read "{1}" {2} > "{3}"'.
	command := commandTemplate format: { self file fullName. keySymbol. tmpFile fullName }.
	NBMacShell run: command.
	output := tmpFile contents.
	tmpFile delete.
	^ output trimRight.