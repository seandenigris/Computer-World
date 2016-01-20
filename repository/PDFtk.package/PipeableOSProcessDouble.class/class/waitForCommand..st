as yet unclassified
waitForCommand: aString

	| output |
	output := self answers at: aString trimRight ifAbsent: [ self error: 'POSP received: ', aString ].
	^ self new
		output: output;
		yourself.