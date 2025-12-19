Class {
	#name : 'CwOnlineFileMorph',
	#superclass : 'Object',
	#category : 'ComputerWorld-Morphic',
	#package : 'ComputerWorld',
	#tag : 'Morphic'
}

{ #category : 'as yet unclassified' }
CwOnlineFileMorph class >> on: anOnlineFile [

	^ UITheme builder newLabel: anOnlineFile address asString. 
]
