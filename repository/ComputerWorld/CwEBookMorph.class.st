Class {
	#name : 'CwEBookMorph',
	#superclass : 'ImageMorph',
	#category : 'ComputerWorld-EBooks'
}

{ #category : 'as yet unclassified' }
CwEBookMorph class >> on: anEBook [

	| instance |
	instance := self withForm: anEBook thumbnail.
	^ instance width: 100.
]
