as yet unclassified
compressDataFile: source to: targetFolder
	| commandTemplate command |
	commandTemplate := '/usr/bin/gzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> source fullName.
		#target -> ((targetFolder / source base), 'gnucash') fullName } asDictionary.
	Halt now.
	Smalltalk tools shell command: command