Class {
	#name : 'CwPList',
	#superclass : 'Object',
	#category : 'ComputerWorld-Core'
}

{ #category : 'instance creation' }
CwPList class >> on: aFileReference [ 

	^ self new
		file: aFileReference;
		yourself.
]

{ #category : 'as yet unclassified' }
CwPList >> at: keySymbol [

	| tmpFile commandTemplate command output |
	tmpFile := ('tmp', DateAndTime now printString asValidSelector, '.txt') asFileReference.
	commandTemplate := 'defaults read "{1}" {2} > "{3}"'.
	command := commandTemplate format: { self file fullName. keySymbol. tmpFile fullName }.
	Smalltalk tools shell waitForCommand: command.
	output := tmpFile contents.
	tmpFile delete.
	^ output trimRight.
]

{ #category : 'private' }
CwPList >> file [
	^ file
]

{ #category : 'private' }
CwPList >> file: aFileReference [
	
	file := aFileReference.
]
