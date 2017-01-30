as yet unclassified
movePhotosFrom: source ToExternalDrive: target
	
	| moveTemplate moveCommand linkTemplate linkCommand |
	self error: 'Not tested! I recommend you step through and verify!!'.
	moveTemplate := 'mv "{1}" "{2}"'.
	moveCommand := moveTemplate format: { source fullName. target fullName }.
	LibC system: moveCommand.
	
	linkTemplate := 'ln -s "{real}" "{link}"'.
	linkCommand := linkTemplate format: { 
		#real -> target.
		#link -> source } asDictionary.
	LibC system: linkCommand