as yet unclassified
attributeNamed: aString

	^ aString asParser, ': ' asParser, self lineSeparator negate plus flatten, self lineSeparator ==> #third.