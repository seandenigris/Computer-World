Class {
	#name : #CwMacApplication,
	#superclass : #Object,
	#category : 'ComputerWorld-Core'
}

{ #category : #'instance creation' }
CwMacApplication class >> reference [

	^ self new.
]

{ #category : #'as yet unclassified' }
CwMacApplication >> activate [

	self tellApplicationTo: 'activate'.
]

{ #category : #actions }
CwMacApplication >> applicationName [

	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
CwMacApplication >> delay: aDuration [ 

	self tellApplicationTo: 'delay ', aDuration seconds asString.
]

{ #category : #actions }
CwMacApplication >> saveAsPdfAt: aFileReference [
	"Saves the current document"

	self tellGUITo: 'click menu item "Print…" of menu 1 of menu bar item "File"  of menu bar 1
	click menu button "PDF"  of sheet 1 of window 1
	-- select menu item 2 of menu 1 of menu button "PDF"  of sheet 1 of window 1
	try
		tell menu item 2 of menu 1 of menu button "PDF"  of sheet 1 of window 1
			select
			set {xPosition, yPosition} to position
			set {xSize, ySize} to size
		end tell
		-- modify offsets if hot spot is not centered:
		click at {xPosition + (xSize div 2), yPosition + (ySize div 2)}
	end try
	
	delay 1
	
	set value of text field 1 of window "Save"  to "', aFileReference basename, '"
	
	-- Open dialog to set path
	key code 5 using {command down, shift down} -- g key'.
	Clipboard clipboardText: aFileReference parent fullName.
	self tellGUITo: 'key code 9 using {command down} -- v key
	click button "Go"  of sheet 1 of window "Save"
	click button "Save"  of window "Save"'.
]

{ #category : #actions }
CwMacApplication >> tellApplicationTo: applescriptCommand [

	| scriptTemplate script isList |
	scriptTemplate := '
		tell application "{1}"
			{2}
		end tell'.
	script := scriptTemplate format: { self applicationName. applescriptCommand }.
	^ Applescript doIt: script.
]

{ #category : #actions }
CwMacApplication >> tellGUITo: applescriptCommand [

	| scriptTemplate script |
	scriptTemplate := '
		tell application "{1}" to activate
		tell application "System Events"
			tell process "{1}"
				{2}
			end tell
		end tell'.
	script := scriptTemplate format: { self applicationName. applescriptCommand }.
	^ Applescript doIt: script.
]

{ #category : #actions }
CwMacApplication >> unquarantine [
	"Only needs to be admin user, not root"

	Smalltalk tools shell runExternally: 'sudo xattr -r -d com.apple.quarantine ', self bundle fullName surroundedByDoubleQuotes
	
	"Reference: 
		- https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra
		- https://apple.stackexchange.com/a/342403/9507"
]
