Class {
	#name : 'CwUiBrowser',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'accessing' }
CwUiBrowser class >> website [
	"Homebrew cask points to old version which fails to install. Manual download from site worked, but it insecure"
	^ 'http://pfiddlesoft.com/uibrowser/' asUrl
]
