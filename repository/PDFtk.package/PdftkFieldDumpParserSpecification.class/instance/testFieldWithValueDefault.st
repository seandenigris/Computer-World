tests-unit
testFieldWithValueDefault

	| field |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 10
FieldValueDefault: 10
FieldJustification: Center
'.

	field := PDFtkFieldDumpParser new field end parse: self sampleInput.
	field default should = '10'.