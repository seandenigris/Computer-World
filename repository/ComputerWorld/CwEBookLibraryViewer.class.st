Class {
	#name : 'CwEBookLibraryViewer',
	#superclass : 'Object',
	#category : 'ComputerWorld-EBooks'
}

{ #category : 'as yet unclassified' }
CwEBookLibraryViewer class >> open [
	"self open"

	^ self new open.
]

{ #category : 'as yet unclassified' }
CwEBookLibraryViewer >> open [

	| builder books content |
	builder := UITheme builder.
	books := CwEBook library collect: [ :b | b asMorph ].
	content := builder
		newColumn: { builder newRow: books }.
	(content openInWindowLabeled: 'Contacts') extent: 400 @ 500
]
