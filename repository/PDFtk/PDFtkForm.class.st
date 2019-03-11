Class {
	#name : #PDFtkForm,
	#superclass : #FileReference,
	#instVars : [
		'fdf'
	],
	#category : 'PDFtk'
}

{ #category : #'instance creation' }
PDFtkForm class >> at: stringOrFileReference [

	^ self fileSystem: FileSystem disk path: stringOrFileReference asFileReference path.
]

{ #category : #accessing }
PDFtkForm >> at: fieldName put: aString [

	self fdf at: fieldName put: aString.
]

{ #category : #private }
PDFtkForm >> fdf [

	^ fdf ifNil: [ fdf := PDFtkAssembledFDF new ].
]

{ #category : #accessing }
PDFtkForm >> fields [

	^ PDFtk dumpFieldsOf: self.
]

{ #category : #'as yet unclassified' }
PDFtkForm >> saveAs: anAbstractFileReference [

	PDFtk new
		saveFilledForm: self to: anAbstractFileReference;
		run.
		
]
