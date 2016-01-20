tests-acceptance
testFields

	| form file fields |
	file := FileLocator imageDirectory / 'Mutual Tour Exchange.pdf'.
	form := PDFtkForm at: file fullName.
	fields := form fields.
	fields first name should = 'Station'.
	fields first value should = '1'.