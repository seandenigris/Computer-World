as yet unclassified
importKey: hexString
	"Adapted from https://www.torproject.org/docs/verifying-signatures.html.en"

	| commandTemplate command exitCode |
	commandTemplate := 'gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys {1}'.
	command := commandTemplate format: { hexString }.
	exitCode := Smalltalk tools shell waitForCommand: command.
	exitCode = 0 ifFalse: [ self error: 'Couldn''t import gpg key' ].