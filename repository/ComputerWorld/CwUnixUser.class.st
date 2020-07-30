Class {
	#name : #CwUnixUser,
	#superclass : #CwUnixUserEntity,
	#category : #'ComputerWorld-Unix'
}

{ #category : #'as yet unclassified' }
CwUnixUser class >> exampleAdmin [
	^ CwUnixUser new
		name: 'admin';
		yourself.
]

{ #category : #'as yet unclassified' }
CwUnixUser >> sudoerIDString [
	^ '#', self id
]

{ #category : #'as yet unclassified' }
CwUnixUser >> sudoerNameString [
	^ self name
]
