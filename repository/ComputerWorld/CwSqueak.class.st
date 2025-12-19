Class {
	#name : 'CwSqueak',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwSqueak class >> downloadVM [
	"GitHub tagged releases don't work on MacOS Sierra, so a more recent VM must be downloaded. URL confirmed via Eliot's blog and Squeak-Dev"
	'https://bintray.com/opensmalltalk/vm/cog/' asUrl open
]
