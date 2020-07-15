Class {
	#name : #CwUnixGroup,
	#superclass : #CwUnixUserEntity,
	#category : #'ComputerWorld-Unix'
}

{ #category : #'as yet unclassified' }
CwUnixGroup >> sudoerIDString [
	^ '%#', self id
]

{ #category : #'as yet unclassified' }
CwUnixGroup >> sudoerNameString [
	^ '%', self name
]
