Class {
	#name : #CwSoftwareMorph,
	#superclass : #Object,
	#instVars : [
		'software'
	],
	#category : 'ComputerWorld-Core'
}

{ #category : #'as yet unclassified' }
CwSoftwareMorph class >> on: aSoftware [

	^ self new setModel: aSoftware.
]

{ #category : #callbacks }
CwSoftwareMorph >> download [

	software download.
]

{ #category : #callbacks }
CwSoftwareMorph >> goToWebPage [

	software webpage open.
]

{ #category : #'as yet unclassified' }
CwSoftwareMorph >> open [
	| builder content webPageText webPageButton downloadText downloadButton |
	builder := UITheme builder.
	webPageText := (builder
		newTextEntryFor: software
		getText: #webpage
		setText: #webpage:
		help: 'Enter the first name of the contact')
		acceptOnCR: false;
		minWidth: 500.
	webPageButton := builder
		newButtonFor: self
		action: #goToWebPage
		label: 'Go'
		help: 'Create a new contact'.
	downloadText := (builder
		newTextEntryFor: software
		getText: #downloadUrl
		setText: #downloadUrl:
		help: 'Enter the last name of the contact')
		acceptOnCR: false;
		minWidth: 500.
	downloadButton := builder
		newButtonFor: self
		action: #download
		label: 'Download'
		help: 'Create a new contact'.
	content := builder
		newLabelGroup: {
			('WebPage' -> (builder newRow: { webPageText. webPageButton })).
			('Download URL' -> (builder newRow: { downloadText. downloadButton })) }.
	content openInWindowLabeled: software fullName
]

{ #category : #private }
CwSoftwareMorph >> setModel: aSoftware [ 

	software := aSoftware.
]
