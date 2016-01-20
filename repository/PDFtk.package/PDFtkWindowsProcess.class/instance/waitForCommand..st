as yet unclassified
waitForCommand: aString

	| command |
	command := aString surroundedByDoubleQuotes.
	process
		startWithShellCommand: command;
		waitForExit.