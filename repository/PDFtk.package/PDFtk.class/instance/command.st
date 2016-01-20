private
command

	| commandTemplate |
	commandTemplate := '"{1}" "{2}" {3} {4}'.
	^ commandTemplate format: { self class binary fullName. inputFile fullName. self operation. self outputFlag }.