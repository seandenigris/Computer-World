as yet unclassified
importKey: hexString

	| commandTemplate command exitCode |
	commandTemplate := 'gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys {1}'.
	command := commandTemplate format: { hexString }.
	exitCode := NBMacShell run: command.
	exitCode = 0 ifFalse: [ self error: 'Couldn''t import gpg key' ].