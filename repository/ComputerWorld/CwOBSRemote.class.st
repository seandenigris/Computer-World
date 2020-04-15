Class {
	#name : #CwOBSRemote,
	#superclass : #ComposablePresenter,
	#instVars : [
		'phoneButton',
		'screenButton',
		'titleButton',
		'transitionButton'
	],
	#category : #'ComputerWorld-Apps'
}

{ #category : #specs }
CwOBSRemote class >> defaultSpec [

	<spec: #default>

	| fontWidth rowHeight buttonHeight |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	rowHeight := self inputTextHeight.
	buttonHeight := rowHeight*1.3.
	
	^ SpecLayout composed
		newColumn: [ :col | 

		col newRow: [ :row | 
				row add: #screenButton.
				row add: #phoneButton.
				row add: #titleButton.
				row add: #transitionButton.
				 ] "height: buttonHeight".
		 ]; 
		yourself.	
]

{ #category : #initialization }
CwOBSRemote >> iconNamed: aSymbol [
	| form |
	form := Form fromFileNamed: FileLocator dynabookData / 'Computer World' / 'Icons' / aSymbol, 'png'.
	^ form scaledToSize: 512 @ 512
]

{ #category : #initialization }
CwOBSRemote >> initializePresenter [

	phoneButton action: [ CwOBS new sendHotkey: 'p' ].
	screenButton action: [ CwOBS new sendHotkey: 's' ].
	titleButton action: [ CwOBS new sendHotkey: 't' ].
	transitionButton action: [ CwOBS new sendHotkey: ' ' ].
]

{ #category : #initialization }
CwOBSRemote >> initializeWidgets [

	phoneButton := self newButton 
		label: 'Phone';
		icon: (self iconNamed: #phone);
		yourself.		
	screenButton := self newButton 
		label: 'Screen';
		icon: (self iconNamed: #screen);
		yourself.
	titleButton := self newButton 
		label: 'Title';
		icon: (self iconNamed: #title);
		yourself.	
	transitionButton := self newButton 
		label: 'Transition';
		icon: (self iconNamed: #transition);
		yourself.	
]

{ #category : #accessing }
CwOBSRemote >> phoneButton [
	^ phoneButton
]

{ #category : #accessing }
CwOBSRemote >> screenButton [
	^ screenButton
]

{ #category : #accessing }
CwOBSRemote >> titleButton [
	^ titleButton
]

{ #category : #accessing }
CwOBSRemote >> transitionButton [
	^ transitionButton
]
