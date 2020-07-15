Class {
	#name : #CwUnixNullUserEntity,
	#superclass : #CwUnixUserEntity,
	#category : #'ComputerWorld-Unix'
}

{ #category : #'as yet unclassified' }
CwUnixNullUserEntity >> sudoerIDString [
	^ 'ALL'
]

{ #category : #'as yet unclassified' }
CwUnixNullUserEntity >> sudoerNameString [
	^ 'ALL'
]
