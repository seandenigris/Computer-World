as yet unclassified
dumpFieldsOf: aPdfForm 

	inputFile := aPdfForm.
	operation := 'dump_data_fields'.
	outputConverter := [ :string | | result |
		result := PDFtkFieldDumpParser parse: string.
		(result isKindOf: PPFailure) ifTrue: [ self error: 'parse failure: ', result message ].
		result ].