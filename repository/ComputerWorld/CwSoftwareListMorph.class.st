Class {
	#name : #CwSoftwareListMorph,
	#superclass : #Object,
	#instVars : [
		'model',
		'contactSelectedIndex'
	],
	#category : 'ComputerWorld-Core'
}

{ #category : #private }
CwSoftwareListMorph >> contactSelectedIndex [

	^ contactSelectedIndex.
]

{ #category : #'private-accessing' }
CwSoftwareListMorph >> contactSelectedIndex: aNumber [

	contactSelectedIndex := aNumber.
	self 
		changed: #contactSelectedIndex;
  		changed: #hasSelectedContact
]

{ #category : #callbacks }
CwSoftwareListMorph >> downloadButtonClick [

	self selectedSoftware download
]

{ #category : #'private-testing' }
CwSoftwareListMorph >> hasSelectedContact [

	^ self contactSelectedIndex > 0.
]

{ #category : #private }
CwSoftwareListMorph >> initialize [

	contactSelectedIndex := 0.
]

{ #category : #callbacks }
CwSoftwareListMorph >> installButtonClick [

	self selectedSoftware install.
]

{ #category : #opening }
CwSoftwareListMorph >> open [
	"self new open"

	| builder content |
	builder := UITheme builder.
	content := builder
		newColumn:
			{(builder
				newListFor: self
				list: #software
				selected: #contactSelectedIndex
				changeSelected: #contactSelectedIndex:
				help: 'Software').
			(builder
				newRow: {
					(builder
						newButtonFor: self
						action: #webPageButtonClick
						getEnabled: #hasSelectedContact
						label: 'Go to Web Page'
						help: 'Go to Web Page of currently selected software').
					(builder
						newButtonFor: self
						action: #downloadButtonClick
						getEnabled: #hasSelectedContact
						label: 'Download'
						help: 'Download current selection').
					(builder
						newButtonFor: self
						action: #installButtonClick
						getEnabled: #hasSelectedContact
						label: 'Install'
						help: 'Install current selection')})}.
	(content openInWindowLabeled: 'Contacts') extent: 400 @ 500
]

{ #category : #private }
CwSoftwareListMorph >> selectedSoftware [

	^ self software at: self contactSelectedIndex
]

{ #category : #private }
CwSoftwareListMorph >> software [

	^ ComputerWorld default software.
]

{ #category : #callbacks }
CwSoftwareListMorph >> webPageButtonClick [

	self selectedSoftware webpage open.
]
