private-tests
testMandatoryAttributeLine

	| parser value |
	self sampleInput: 'FieldName: MyField
'.

	parser := PDFtkFieldDumpParser new attributeNamed: 'FieldName'.
	value := parser parse: self sampleInput.
	value should = 'MyField'.