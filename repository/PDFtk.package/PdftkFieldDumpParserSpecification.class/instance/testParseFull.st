tests-acceptance
testParseFull

	| fields |
	self sampleInput: '---
FieldType: Text
FieldName: Station
FieldFlags: 0
FieldValue: 1
FieldJustification: Center
---
FieldType: Text
FieldName: Relief
FieldFlags: 0
FieldValue: Jimmy
FieldJustification: Left
'.

	fields := PDFtkFieldDumpParser parse: self sampleInput.
	fields first name should = 'Station'.
	fields first value should = '1'.
	fields second name should = 'Relief'.
	fields second value should = 'Jimmy'.