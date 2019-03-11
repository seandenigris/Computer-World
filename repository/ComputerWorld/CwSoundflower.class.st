Class {
	#name : #CwSoundflower,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwSoundflower class >> install [
	"As administrator"
	'brew cask install soundflower'
]
