Class {
	#name : 'CwEBook',
	#superclass : 'Object',
	#instVars : [
		'file'
	],
	#classInstVars : [
		'library'
	],
	#category : 'ComputerWorld-EBooks'
}

{ #category : 'library (will be extracted from class)' }
CwEBook class >> addToLibrary: aDirectoryEntry [

	| resourceFile book |
	resourceFile := Resources library import: aDirectoryEntry.
	book := CwEBook from: resourceFile.
	library add: book.
]

{ #category : 'instance creation' }
CwEBook class >> from: aDirectoryEntryFile [

	^ self new setFile: aDirectoryEntryFile.
]

{ #category : 'library (will be extracted from class)' }
CwEBook class >> library [

	^ library ifNil: [ library := OrderedCollection new ].
]

{ #category : 'persistence' }
CwEBook class >> restoreFrom: anObject [

	library := anObject.
]

{ #category : 'persistence' }
CwEBook class >> spData [

	^ library
]

{ #category : 'as yet unclassified' }
CwEBook >> asMorph [

	^ CwEBookMorph on: self.
]

{ #category : 'as yet unclassified' }
CwEBook >> open [

	file open.
]

{ #category : 'as yet unclassified' }
CwEBook >> setFile: aDirectoryEntryFile [

	file := aDirectoryEntryFile.
	^ self.
]

{ #category : 'as yet unclassified' }
CwEBook >> thumbnail [

	^ file thumbnail.
]
