API
output

	| output response |
	output := String streamContents: [ :out |
		[ | lines |
			out nextPutAll: self process upToEnd.
			lines := out contents lines.
			lines isEmpty not and: [ lines last beginsWith: self prompt ] ] whileFalse ].

	"Strip original command and prompt at end. This will not work for multi-line commands"
	response := output contents copyUpToLast: Character cr.
	^ response copyAfter: Character lf.