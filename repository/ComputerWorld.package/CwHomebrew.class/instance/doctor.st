as yet unclassified
doctor
	"#install outputs a message to do this"

	| exitCode |
	exitCode := Smalltalk tools shell waitForCommand: '/usr/local/bin/brew doctor'.
	exitCode = 0 ifFalse: [ self error: 'brew doctor failed' ].