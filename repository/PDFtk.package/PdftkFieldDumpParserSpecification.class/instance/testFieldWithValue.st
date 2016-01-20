tests-unit
testFieldWithValue

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field parse: self sampleInput.
	field name should = 'Station'.
	field value should = '1'.
	