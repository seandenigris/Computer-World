as yet unclassified
uncompressDataFile: reference to: target
	| commandTemplate command |
	commandTemplate := '/usr/bin/gunzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> reference fullName.
		#target -> target fullName } asDictionary.
	Smalltalk tools shell command: command