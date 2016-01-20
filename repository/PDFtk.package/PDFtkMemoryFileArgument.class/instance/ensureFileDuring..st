as yet unclassified
ensureFileDuring: aBlock
	
	tempFile := PDFtk tempFolder / ('PDFtkTemp', DateAndTime now asString) asLegalSelector, 'fdf'.
	model saveTo: tempFile.
	aBlock ensure: [ tempFile delete ].