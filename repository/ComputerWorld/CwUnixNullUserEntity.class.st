Class {
	#name : 'CwUnixNullUserEntity',
	#superclass : 'SuUnixUserEntity',
	#category : 'ComputerWorld-Unix',
	#package : 'ComputerWorld',
	#tag : 'Unix'
}

{ #category : 'as yet unclassified' }
CwUnixNullUserEntity >> sudoerIDString [
	^ 'ALL'
]

{ #category : 'as yet unclassified' }
CwUnixNullUserEntity >> sudoerNameString [
	^ 'ALL'
]
