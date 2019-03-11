Class {
	#name : #PDFtkAssembledFDF,
	#superclass : #Object,
	#instVars : [
		'lines',
		'fields'
	],
	#category : 'PDFtk-Experimental'
}

{ #category : #'pdftk adaption' }
PDFtkAssembledFDF >> asPDFtkArgument [

	^ PDFtkMemoryFileArgument on: self.
]

{ #category : #'as yet unclassified' }
PDFtkAssembledFDF >> at: fieldName put: aString [

	fields at: fieldName put: aString.
]

{ #category : #'as yet unclassified' }
PDFtkAssembledFDF >> initialize [

	super initialize.
	fields := Dictionary new.
]

{ #category : #'as yet unclassified' }
PDFtkAssembledFDF >> saveTo: file [

	file writeStreamDo: [ :str | 
		str
			nextPutAll: PDFtkFdfFormat new header; lf;
			nextPutAll: (PDFtkFdfFormat new bodyWith: fields); lf;
			nextPutAll: PDFtkFdfFormat new trailer ].

]
