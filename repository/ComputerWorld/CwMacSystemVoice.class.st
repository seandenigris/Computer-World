"
A system voice installed on your Mac. Not all voices are installed by Default.
"
Class {
	#name : #CwMacSystemVoice,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwMacSystemVoice class >> allInstalled [
	"You can also view/add voices in Preferences->Accessibility->Speech
	"

	^ Smalltalk tools shell new outputOf: 'say -v ?'
]
