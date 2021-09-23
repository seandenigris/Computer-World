Extension { #name : 'SuRSync' }

{ #category : '*ComputerWorld' }
SuRSync class >> exampleScript [
	<sampleInstance>
	| exclusions subfolder source destination options commandTemplate exclusionFlag command |
	self flag: 'Use case script to be reimplemented with our real model'.
	exclusions := #(
	"'ABCD1234.JPG'
	'WXYZ5678.MOV'"
	).
	subfolder := CwIPhone new multimediaRootPath / '103APPLE'.
	source := '/share/Apple iPhone/' asFileReference
		resolvePath: subfolder.
	destination := '/path/to/target/root/' asFileReference
		resolvePath: subfolder.
	options := '-aEAX'.	"E-executability, A - ACLs, X - extended attributes; W irrelevant for first run. z 50% slower"
	commandTemplate := 'rsync {options} --progress {exclusionFlag} "{source}" "{destination}"'.
	exclusionFlag := String
		streamContents: [ :s | 
			exclusions
				do: [ :e | 
					s
						nextPutAll: '--exclude ';
						nextPutAll: e ]
				separatedBy: [ s space ] ].
	^ command := commandTemplate
		format:
			{(#options -> options).
			(#exclusionFlag -> exclusionFlag).
			(#source -> (source fullName , '/')).
			(#destination -> destination fullName)} asDictionary
]
