Class {
	#name : #CwLGHub,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwLGHub class >> bundle [
	^ '/Applications/lghub.app' asFileReference
]

{ #category : #accessing }
CwLGHub >> manual [
	^ Smalltalk tools webBrowser new open: 'https://www.logitech.com/assets/65550/ghub.pdf'
]
