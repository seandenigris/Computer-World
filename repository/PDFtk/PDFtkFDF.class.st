"
Acceptable formats:
	PDFtk 1.41: UTF-8 (pretty easy to create manually); does not seem to accept UTF-16
"
Class {
	#name : #PDFtkFDF,
	#superclass : #Object,
	#instVars : [
		'lines'
	],
	#category : 'PDFtk'
}

{ #category : #'instance creation' }
PDFtkFDF class >> for: aPdfForm [ 

	^ self new
		form: aPdfForm;
		yourself.
]

{ #category : #'pdftk adaption' }
PDFtkFDF >> asPDFtkArgument [

	^ PDFtkMemoryFileArgument on: self.
]

{ #category : #'as yet unclassified' }
PDFtkFDF >> at: fieldName put: aString [

	| fieldNameParser parser nameLine nameIndex bom valueLine isUtf16 encodedValue |
	bom := String with: 254 asCharacter with: 255 asCharacter.
	fieldNameParser := bom asParser optional.
	fieldName do: [ :char | fieldNameParser := fieldNameParser, Character null asParser optional, char asParser ].
	parser := '/T (' asParser, fieldNameParser, $) asParser end.
	nameLine := lines detect: [ :e | parser matches: e ] ifNone: [ self error: 'Fdf does not contain a ', fieldName, ' field' ].
	nameIndex := lines indexOf: nameLine. 
	valueLine := lines at: nameIndex - 1.
	isUtf16 := valueLine includesSubstring: bom.
	encodedValue := isUtf16
		ifTrue: [ 
			String streamContents: [ :str |
				str
					nextPutAll: '/V (';
					nextPutAll: bom.
				aString do: [ :char |
					str
						nextPut: Character null;
						nextPut: char ].
				str nextPut: $) ] ]
		ifFalse: [ '/V (', aString, ')' ].
	lines at: nameIndex - 1 put: encodedValue.
]

{ #category : #private }
PDFtkFDF >> form: aPdfForm [ 

	| contents |
	contents := PDFtk new
		generateFdfFor: aPdfForm;
		toStdOut;
		run.
	lines := contents lines.
]

{ #category : #private }
PDFtkFDF >> hasFieldNamed: aString [ 

	^ lines anySatisfy: [ :e | '/T (', aString, ')' = e ].
]

{ #category : #'as yet unclassified' }
PDFtkFDF >> saveTo: file [

	file writeStreamDo: [ :str | lines do: [ :line | str nextPutAll: line ] separatedBy: [ str lf ] ].

]
