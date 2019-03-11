Class {
	#name : #PDFtkMemoryFileArgument,
	#superclass : #Object,
	#instVars : [
		'model',
		'tempFile'
	],
	#category : 'PDFtk'
}

{ #category : #'instance creation' }
PDFtkMemoryFileArgument class >> on: anObject [

	^ self new
		model: anObject;
		yourself.
]

{ #category : #'as yet unclassified' }
PDFtkMemoryFileArgument >> appendedTo: aString [ 

	^ aString, ' ', tempFile fullName surroundedByDoubleQuotes.
]

{ #category : #'as yet unclassified' }
PDFtkMemoryFileArgument >> ensureFileDuring: aBlock [
	
	tempFile := PDFtk tempFolder / ('PDFtkTemp', DateAndTime now asString) asLegalSelector, 'fdf'.
	model saveTo: tempFile.
	aBlock ensure: [ tempFile delete ].
]

{ #category : #private }
PDFtkMemoryFileArgument >> model: anObject [

	model := anObject.
]
