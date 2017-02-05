as yet unclassified
uncompressDataFile: reference
	| commandTemplate command |
	commandTemplate := '/usr/bin/gunzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> reference fullName.
		#target -> ((reference parent / reference base), 'xml') fullName } asDictionary.
	Smalltalk tools shell command: command