as yet unclassified
at: fieldName put: aString

"	(self hasFieldNamed: fieldName) ifFalse: [ self error: 'Fdf does not contain a ', fieldName, ' field' ]."
"	lines before: '/T (', fieldName, ')'"
	| nameIndex |
	nameIndex := lines indexOf: '/T (', fieldName, ')' ifAbsent: [ self error: 'Fdf does not contain a ', fieldName, ' field' ].
	lines at: nameIndex - 1 put: '/V (', aString, ')'.