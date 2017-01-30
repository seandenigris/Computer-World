private
prepareForCommands

	self run: 'PS1="', self prompt, '"'.
	[
		[ | output lines |
			output := self process upToEnd.
			lines := output lines.
			lines isEmpty not and: [ lines last beginsWith: self prompt ] ] whileFalse.
	] valueWithin: self loginTimeout onTimeout: [ self error: 'Never got shell prompt' ].