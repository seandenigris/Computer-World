as yet unclassified
initialize

	super initialize.
	outputConverter := [ :string | string ].
	outputFlag := ''.
	operationInput := PDFtkNullOperationInput new.