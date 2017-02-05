as yet unclassified
verify: file with: key
	"Adapted from https://www.torproject.org/docs/verifying-signatures.html.en"

	| commandTemplate command exitCode |
	commandTemplate := '/usr/local/bin/gpg --verify "{1}" "{2}"'.
	command := commandTemplate format: { key fullName. file fullName }.
	exitCode := Smalltalk tools shell waitForCommand: command.
	exitCode = 0
		ifTrue: [ self inform: file base, ' validated!' ]
		ifFalse: [ self error: file base, ' failed validation' ].