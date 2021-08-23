Class {
	#name : 'CwOnlineFile',
	#superclass : 'Object',
	#instVars : [
		'url'
	],
	#category : 'ComputerWorld-Core'
}

{ #category : 'as yet unclassified' }
CwOnlineFile class >> at: aUrl [

	^ self new setUrl: aUrl.
]

{ #category : 'as yet unclassified' }
CwOnlineFile >> = rhs [

	^ self address asString = rhs address asString.
]

{ #category : 'as yet unclassified' }
CwOnlineFile >> address [

	^ url.
]

{ #category : 'as yet unclassified' }
CwOnlineFile >> asMorph [

	^ CwOnlineFileMorph on: self.
]

{ #category : 'as yet unclassified' }
CwOnlineFile >> hash [

	^ self address hash.
]

{ #category : 'as yet unclassified' }
CwOnlineFile >> setUrl: aUrl [

	url := aUrl.
	^ self.
]
