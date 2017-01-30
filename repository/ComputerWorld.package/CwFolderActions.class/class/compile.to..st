private
compile: applescriptString to: aFileReference

	| commandTemplate commandString p |
	commandTemplate := '/usr/bin/osacompile -o {1} <<END_S
{2}
END_S'.
	commandString := commandTemplate format: { aFileReference fullName surroundedByDoubleQuotes. applescriptString }.
	"Heredocs require very precise line breaks. Mac expects lfs, but Pharo defaults to crs"
	commandString := commandString copyReplaceAll: Character cr asString with: Character lf asString.
	p := PipeableOSProcess waitForCommand: commandString.
	p succeeded ifFalse: [ self error: p errorUpToEndOfFile ].