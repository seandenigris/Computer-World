tests-unit
testFieldWithoutValue

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field parse: self sampleInput.
	field name should = 'Station'.
	field value should = ''.
	