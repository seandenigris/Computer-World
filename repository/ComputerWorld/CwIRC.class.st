Class {
	#name : #CwIRC,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwIRC >> verifyIdentityWith: password [

	^ '/msg NickServ IDENTIFY ', password
]
