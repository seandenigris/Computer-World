Class {
	#name : 'CwShaSum',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac',
	#package : 'ComputerWorld',
	#tag : 'Mac'
}

{ #category : 'as yet unclassified' }
CwShaSum >> assertSha: algorithmNumber for: file equals: aString [
	
	| commandTemplate tmpOutputFile command computedSha |
	commandTemplate := 'shasum -a {1} "{2}" > "{3}"'.
	tmpOutputFile := ('sha', file fullName asValidSelector, '.txt') asFileReference.
	command := commandTemplate format: { algorithmNumber asString. file fullName. tmpOutputFile fullName }.
	Smalltalk tools shell waitForCommand: command.
	computedSha := tmpOutputFile contents copyUpTo: Character space.
	self assert: computedSha = aString.
	
]
