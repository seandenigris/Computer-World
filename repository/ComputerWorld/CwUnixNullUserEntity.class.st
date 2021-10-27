Class {
	#name : #CwUnixNullUserEntity,
	#superclass : #SuUnixUserEntity,
	#category : 'ComputerWorld-Unix'
}

{ #category : #'as yet unclassified' }
CwUnixNullUserEntity >> sudoerIDString [
	^ 'ALL'
]

{ #category : #'as yet unclassified' }
CwUnixNullUserEntity >> sudoerNameString [
	^ 'ALL'
]
