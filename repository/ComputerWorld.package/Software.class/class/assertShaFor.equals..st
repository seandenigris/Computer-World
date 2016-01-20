as yet unclassified
assertShaFor: file equals: aString
	"This should obviously be better integrated i.e. on the instance side, etc."
	
	| commandTemplate tmpOutputFile command computedSha |
	commandTemplate := 'shasum "{1}" > "{2}"'.
	tmpOutputFile := ('sha', file fullName asLegalSelector, '.txt') asFileReference.
	command := commandTemplate format: { file fullName. tmpOutputFile fullName }.
	NBMacShell run: command.
	computedSha := tmpOutputFile contents copyUpTo: Character space.
	self assert: computedSha = aString.
	