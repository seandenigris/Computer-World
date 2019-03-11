Class {
	#name : #PDFtkWindowsProcess,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : 'PDFtk'
}

{ #category : #'as yet unclassified' }
PDFtkWindowsProcess class >> waitForCommand: aString [

	^ self new
		waitForCommand: aString;
		yourself.
]

{ #category : #'as yet unclassified' }
PDFtkWindowsProcess >> initialize [

	super initialize.

	process := ProcessWrapper new.
	process
		useStdout;
		useStderr.
]

{ #category : #'as yet unclassified' }
PDFtkWindowsProcess >> output [

	^ process upToEnd.

]

{ #category : #'as yet unclassified' }
PDFtkWindowsProcess >> waitForCommand: aString [

	| command |
	command := aString surroundedByDoubleQuotes.
	process
		startWithShellCommand: command;
		waitForExit.
]
