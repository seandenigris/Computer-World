Class {
	#name : #CwGHub,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwGHub >> manual [
	^ Smalltalk tools webBrowser new open: 'https://www.logitech.com/assets/65550/ghub.pdf'
]
