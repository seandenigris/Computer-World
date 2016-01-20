private-tests
testOptionalAttributeLine

	| parser value |
	self sampleInput: 'FieldName: MyField
'.

	parser := PDFtkFieldDumpParser new optionalAttributeNamed: 'FieldName'.
	value := parser parse: self sampleInput.
	value should = 'MyField'.