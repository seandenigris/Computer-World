"
Example:

shell := SshShell on: ipAddress as: userName withPassword: password.
shell run: 'pwd'.
shell output.
"
Class {
	#name : 'CwSshShell',
	#superclass : 'Object',
	#instVars : [
		'process',
		'password',
		'ipAddress',
		'username',
		'prompt'
	],
	#category : 'ComputerWorld-Core',
	#package : 'ComputerWorld',
	#tag : 'Core'
}

{ #category : 'private' }
CwSshShell class >> downloadExpectScript [

	| response |
	response := ZnEasy get: 'https://gist.github.com/seandenigris/4945436/raw'.
	response isSuccess ifFalse: [ self error: 'Could not download expect script. Got ', response asString ].
	FileStream fileNamed: self expectFileReference do: [ :file | file nextPutAll: response contents ].
]

{ #category : 'private' }
CwSshShell class >> expectFile [

	self expectFileReference exists ifFalse: [ self downloadExpectScript ].
	^ self expectFileReference.
]

{ #category : 'private' }
CwSshShell class >> expectFileReference [

	^ FileLocator imageDirectory / 'expect.exp'.
]

{ #category : 'instance creation' }
CwSshShell class >> on: ipAddressString as: userString withPassword: passwordString [

	^ self new
			ipAddress: ipAddressString;
			username: userString;
			password: passwordString;
			yourself.
]

{ #category : 'private-accessing' }
CwSshShell >> expectFile [

	^ self class expectFile.
]

{ #category : 'private-accessing' }
CwSshShell >> ipAddress: aString [ 

	ipAddress := aString.
]

{ #category : 'private-accessing' }
CwSshShell >> loginTimeout [

	^ 5 seconds.
]

{ #category : 'API' }
CwSshShell >> output [

	| output response |
	output := String streamContents: [ :out |
		[ | lines |
			out nextPutAll: self process upToEnd.
			lines := out contents lines.
			lines isEmpty not and: [ lines last beginsWith: self prompt ] ] whileFalse ].

	"Strip original command and prompt at end. This will not work for multi-line commands"
	response := output contents copyUpToLast: Character cr.
	^ response copyAfter: Character lf.
]

{ #category : 'private-accessing' }
CwSshShell >> password: aString [ 

	password := aString.
]

{ #category : 'private' }
CwSshShell >> prepareForCommands [

	self run: 'PS1="', self prompt, '"'.
	[
		[ | output lines |
			output := self process upToEnd.
			lines := output lines.
			lines isEmpty not and: [ lines last beginsWith: self prompt ] ] whileFalse.
	] valueWithin: self loginTimeout onTimeout: [ self error: 'Never got shell prompt' ].
]

{ #category : 'private-accessing' }
CwSshShell >> process [

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
]

{ #category : 'private-accessing' }
CwSshShell >> prompt [

	^ prompt := 'UNIQUE_PROMPT$'.
]

{ #category : 'API' }
CwSshShell >> run: aString [ 

	self process
		nextPutAll: aString;
		nextPut: Character lf.
]

{ #category : 'private-accessing' }
CwSshShell >> username: aString [ 

	username := aString.
]
