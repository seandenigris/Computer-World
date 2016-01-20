as yet unclassified
testFormDumpFields

	| form pdfPathString fields |
	pdfPathString := '/usr/local/form.pdf'.
	form := PdfForm at: pdfPathString.
	
	PipeableOSProcessDouble
		onCommand: PDFtk binary fullName surroundedByDoubleQuotes, ' ', pdfPathString surroundedByDoubleQuotes, ' dump_data_fields'
		answer: PDFtk sampleFieldDumpOutput.
	
	fields := PDFtk dumpFieldsOf: form.
	fields size = 1.
	fields first name should = 'Station'.