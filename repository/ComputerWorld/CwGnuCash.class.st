Class {
	#name : #CwGnuCash,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #'file compression' }
CwGnuCash class >> compressDataFile: source to: targetFolder [
	| commandTemplate command |
	commandTemplate := '/usr/bin/gzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> source fullName.
		#target -> ((targetFolder / source base), 'gnucash') fullName } asDictionary.
	Smalltalk tools shell command: command
]
