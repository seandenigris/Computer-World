"
The Pdftk command format consists of:
binary input_file operation output_file

where:
- input_file can be from prompt | stdin | filename
- output_file is keyword output plus any of three above options
- operation seems mostly to be a keyword and possibly a file argument (any of three kinds above)
"
Class {
	#name : #PDFtk,
	#superclass : #Object,
	#instVars : [
		'command',
		'outputConverter',
		'outputFlag',
		'operation',
		'inputFile',
		'operationInput'
	],
	#classInstVars : [
		'runnerClass'
	],
	#category : 'PDFtk'
}

{ #category : #accessing }
PDFtk class >> binary [

	^ Smalltalk os isWin32
		ifTrue: [ FileLocator imageDirectory / 'lib' / 'pdftk.exe' ]
		ifFalse:[ '/usr/local/bin/pdftk' asFileReference ].
]

{ #category : #'as yet unclassified' }
PDFtk class >> dumpFieldsOf: aPdfForm [ 

	^ self new
		dumpFieldsOf: aPdfForm;
		run.
]

{ #category : #accessing }
PDFtk class >> runnerClass [

	runnerClass ifNotNil: [ ^ runnerClass ].

	^ Smalltalk os isWin32 
		ifTrue: [ PDFtkWindowsProcess ]
		ifFalse: [ PipeableOSProcess ].
]

{ #category : #'as yet unclassified' }
PDFtk class >> runnerClass: aClass [

	 runnerClass := aClass.
]

{ #category : #'*PDFtk-Specification' }
PDFtk class >> sampleFieldDumpOutput [

	^ '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
' withUnixLineEndings.
]

{ #category : #accessing }
PDFtk class >> tempFolder [

	^ (FileLocator imageDirectory / 'tmp' / 'PDFtk') ensureDirectory.
]

{ #category : #private }
PDFtk >> command [

	| commandTemplate |
	commandTemplate := '"{1}" "{2}" {3} {4}'.
	^ commandTemplate format: { self class binary fullName. inputFile fullName. self operation. self outputFlag }.
]

{ #category : #'as yet unclassified' }
PDFtk >> dumpFieldsOf: aPdfForm [ 

	inputFile := aPdfForm.
	operation := 'dump_data_fields'.
	outputConverter := [ :string | | result |
		result := PDFtkFieldDumpParser parse: string.
		(result isKindOf: PPFailure) ifTrue: [ self error: 'parse failure: ', result message ].
		result ].
]

{ #category : #'as yet unclassified' }
PDFtk >> generateFdfFor: aPdfForm [ 

	inputFile := aPdfForm.
	operation := 'generate_fdf'.
]

{ #category : #'as yet unclassified' }
PDFtk >> initialize [

	super initialize.
	outputConverter := [ :string | string ].
	outputFlag := ''.
	operationInput := PDFtkNullOperationInput new.
]

{ #category : #private }
PDFtk >> operation [

	^ operationInput appendedTo: operation.
]

{ #category : #'as yet unclassified' }
PDFtk >> outputFlag [

	^ outputFlag.
]

{ #category : #'as yet unclassified' }
PDFtk >> run [

	| process |
	operationInput ensureFileDuring: [
		process := self class runnerClass waitForCommand: self command ].
	^ outputConverter value: process output.
]

{ #category : #'as yet unclassified' }
PDFtk >> saveFilledForm: aPdfForm to: anAbstractFileReference [

	inputFile := aPdfForm.
	operation := 'fill_form'.
	operationInput := aPdfForm fdf asPDFtkArgument.
	outputFlag := 'output ', anAbstractFileReference fullName surroundedByDoubleQuotes.
]

{ #category : #output }
PDFtk >> toStdOut [

	outputFlag := 'output -'.
]
