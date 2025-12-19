Class {
	#name : 'CwIRC',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwIRC >> verifyIdentityWith: password [

	^ '/msg NickServ IDENTIFY ', password
]
