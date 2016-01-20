accessing
runnerClass

	runnerClass ifNotNil: [ ^ runnerClass ].

	^ Smalltalk os isWin32 
		ifTrue: [ PDFtkWindowsProcess ]
		ifFalse: [ PipeableOSProcess ].