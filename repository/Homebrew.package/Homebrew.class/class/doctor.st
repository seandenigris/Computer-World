as yet unclassified
doctor
	"#install outputs a message to do this"

	| exitCode |
	exitCode := NBMacShell run: '/usr/local/bin/brew doctor'.
	exitCode = 0 ifFalse: [ self error: 'brew doctor failed' ].