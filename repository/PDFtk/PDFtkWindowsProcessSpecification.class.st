Class {
	#name : #PDFtkWindowsProcessSpecification,
	#superclass : #BabyPhexample,
	#category : 'PDFtk-Specification'
}

{ #category : #'as yet unclassified' }
PDFtkWindowsProcessSpecification >> test1 [

	"I want to test that the uderlying ProcessWrapper recieves the messages necessary for the code to work. However, I don't want to add accessors on the class-side, where they would need to be to test this class-side convenience method.
	I would like to say:
		evaluator := context mock: 'evaluator'.
		evaluator should receive: #useStdOut.
		evaluator should receive: #startWithShellCommand:; with: 'command string'.
		evaluator can receive: #upToEnd; answers: 'command output'.
		PDFtkWindowsProcess stub message: #evaluator; answers: evaluator."
	| process |
	process := PDFtkWindowsProcess waitForCommand: ''.
	process output should = 'command output'.
	
	"Then I'd like to extract all the commented part into:
		self shouldEvaluate: aString"
]
