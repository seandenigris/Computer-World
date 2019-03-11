Class {
	#name : #PDFtkFormField,
	#superclass : #Object,
	#instVars : [
		'name',
		'value',
		'default'
	],
	#category : 'PDFtk'
}

{ #category : #accessing }
PDFtkFormField >> default [

	^ default
]

{ #category : #accessing }
PDFtkFormField >> default: aString [

	default := aString.
]

{ #category : #accessing }
PDFtkFormField >> name [

	^ name.
]

{ #category : #accessing }
PDFtkFormField >> name: aString [

	name := aString.
]

{ #category : #'as yet unclassified' }
PDFtkFormField >> printOn: aStream [

	aStream
		nextPutAll: 'Field ';
		nextPutAll: self name surroundedBySingleQuotes;
		nextPutAll: ' = ';
		nextPutAll: self value surroundedBySingleQuotes.
]

{ #category : #accessing }
PDFtkFormField >> value [

	^ value.
]

{ #category : #accessing }
PDFtkFormField >> value: aString [

	value := aString.
]
