as yet unclassified
ensureFileDuring: aBlock
	
	tempFile := FileLocator imageDirectory / ('PDFtkTemp', DateAndTime now asString) asLegalSelector.
	model saveTo: tempFile.
	aBlock ensure: [ tempFile delete ].