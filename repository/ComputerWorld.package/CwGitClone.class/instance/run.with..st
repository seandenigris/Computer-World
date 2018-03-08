as yet unclassified
run: template with: arguments
	| command exitCode |
	command := template format: { #location -> self location fullName. #gitBinary -> self gitBinary } asDictionary, arguments asDictionary.
	exitCode := LibC system: command.
	self assert: exitCode = 0