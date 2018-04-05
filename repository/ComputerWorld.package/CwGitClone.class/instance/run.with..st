as yet unclassified
run: template with: arguments
	| command exitCode fullTemplate |
	fullTemplate := 'cd "{rootFolder}"; ', template.
	command := fullTemplate format: { #rootFolder -> self location fullName. #gitBinary -> self gitBinary fullName } asDictionary, arguments asDictionary.
	exitCode := LibC system: command.
	self assert: exitCode = 0