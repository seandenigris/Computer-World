"
A system voice installed on your Mac. Not all voices are installed by Default.

There are several ways to access voices:
- Unixy `say` command - both Unixy and Applescript version
- Cocoa (e.g. `[NSSpeechSynthesizer availableVoices]`)
- Accessibility Preferences
"
Class {
	#name : 'CwMacSystemVoice',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac',
	#package : 'ComputerWorld',
	#tag : 'Mac'
}

{ #category : 'as yet unclassified' }
CwMacSystemVoice class >> allInstalled [
	"You can also view/add voices in Preferences->Accessibility->Speech
	"

	^ Smalltalk tools shell new outputOf: 'say -v ?'
]
