tests-unit
testCreation

	| pathString form |
	pathString := '/usr/local/form.pdf'.
	form := PdfForm at: pathString.
	form fullName should = pathString.