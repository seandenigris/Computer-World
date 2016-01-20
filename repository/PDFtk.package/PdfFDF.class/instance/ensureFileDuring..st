pdftk adaption
ensureFileDuring: aBlock
	
	| tempFdfFile |
	tempFdfFile := FileLocator imageDirectory / ('tempFdf', DateAndTime now asString) asLegalSelector.
	self saveTo: tempFdfFile.
	aBlock value ensure: [ tempFdfFile delete ].