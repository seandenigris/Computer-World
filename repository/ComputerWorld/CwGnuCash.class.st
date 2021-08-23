Class {
	#name : 'CwGnuCash',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'file compression' }
CwGnuCash class >> compressDataFile: source to: targetFolder [
	| commandTemplate command |
	commandTemplate := '/usr/bin/gzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> source fullName.
		#target -> ((targetFolder / source base), 'gnucash') fullName } asDictionary.
	Smalltalk tools shell command: command
]

{ #category : 'file compression' }
CwGnuCash class >> uncompressDataFile: reference [
	self uncompressDataFile: reference to: (reference parent / reference base), 'xml'
]

{ #category : 'file compression' }
CwGnuCash class >> uncompressDataFile: reference to: target [
	| commandTemplate command |
	commandTemplate := '/usr/bin/gunzip -c "{source}" > "{target}"'.
	command := commandTemplate format: { 
		#source -> reference fullName.
		#target -> target fullName } asDictionary.
	Smalltalk tools shell command: command
]
