Class {
	#name : 'CwFacebook',
	#superclass : 'Object',
	#category : 'ComputerWorld-Core',
	#package : 'ComputerWorld',
	#tag : 'Core'
}

{ #category : 'initialization' }
CwFacebook >> resetThumbnail [
	Smalltalk tools webBrowser new open: 'https://developers.facebook.com/tools/debug'
]
