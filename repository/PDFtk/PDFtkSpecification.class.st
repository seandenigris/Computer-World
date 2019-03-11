Class {
	#name : #PDFtkSpecification,
	#superclass : #BabyPhexample,
	#category : 'PDFtk-Specification'
}

{ #category : #'as yet unclassified' }
PDFtkSpecification >> setUp [
	
	PDFtk runnerClass: PipeableOSProcessDouble.
]

{ #category : #'as yet unclassified' }
PDFtkSpecification >> tearDown [

	PDFtk runnerClass: PipeableOSProcess.
	PipeableOSProcessDouble reset.
]

{ #category : #'as yet unclassified' }
PDFtkSpecification >> testFormDumpFields [

	| form pdfPathString fields |
	pdfPathString := '/usr/local/form.pdf'.
	form := PDFtkForm at: pdfPathString.
	
	PipeableOSProcessDouble
		onCommand: PDFtk binary fullName surroundedByDoubleQuotes, ' ', pdfPathString surroundedByDoubleQuotes, ' dump_data_fields'
		answer: PDFtk sampleFieldDumpOutput.
	
	fields := PDFtk dumpFieldsOf: form.
	fields size = 1.
	fields first name should = 'Station'.
]
