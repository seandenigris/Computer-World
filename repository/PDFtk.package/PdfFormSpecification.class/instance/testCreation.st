tests-unit
testCreation

	| pathString form |
	pathString := '/usr/local/form.pdf'.
	form := PDFtkForm at: pathString.
	form fullName should = pathString.