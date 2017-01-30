private-accessing
process

	| escapedPassword expectCommandTemplate expectCommand |
	process ifNotNil: [ :p | ^ p ].
	
	escapedPassword := password copyReplaceAll: '"' with: '\"'.
	expectCommandTemplate := '/usr/bin/expect {1} ssh {2} {3} {4}'.
	expectCommand := expectCommandTemplate format: { 
		self expectFile fullName surroundedByDoubleQuotes.
		ipAddress.
		username.
		escapedPassword }.
	process := PipeableOSProcess command: expectCommand.

	"Must be non-blocking, or #upToEnd hangs the image"
	process setNonBlockingOutput.
	
	self prepareForCommands.
	
	^ process.