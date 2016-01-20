as yet unclassified
run

	| process |
	operationInput ensureFileDuring: [
		process := self class runnerClass waitForCommand: self command ].
	^ outputConverter value: process output.