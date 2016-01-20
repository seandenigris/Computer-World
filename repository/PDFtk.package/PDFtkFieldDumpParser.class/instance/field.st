as yet unclassified
field

	| type name flags value justification header default |
	header := '---' asParser, self lineSeparator ==> #first.
	type := self attributeNamed: 'FieldType'.
	name := self attributeNamed: 'FieldName'.
	flags := self attributeNamed: 'FieldFlags'.
	value := self optionalAttributeNamed: 'FieldValue'.
	default := self attributeNamed: 'FieldValueDefault'.
	justification := self attributeNamed: 'FieldJustification'.
	^ header, type, name, flags, value, default optional, justification ==> [ :nodes |
			PDFtkFormField new
				name: nodes third;
				value: nodes fifth;
				default: nodes sixth ].