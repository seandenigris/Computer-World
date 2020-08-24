"
There are two ways to use me.

!Generic Application Mode
This may be how most applications start out. There is no behavior yet to justify a subclass, and we may never come back to implement any, so we ${example:CwMacApplication>>#mail|label='just specify a bundle'}$ and we're able to do things that are universal to all applications, like ${method:CwMacApplication>>#unquarantine|label=unquarantine}$.
!Application with Specific Behavior
Once we begin to implement features unqiue to the app, a subclass is in order. Here are some already available:
[[[language=smalltalk
CwMacApplication allSubclasses
]]]
"
Class {
	#name : #CwMacApplication,
	#superclass : #Object,
	#instVars : [
		'bundle'
	],
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwMacApplication class >> bundle [
	"Subclasses can override instead of setting on the instance-side, so that the bundle is availalbe without an instance. This seems to make sense as on the Mac a bundle is something one may reason about independently from the application e.g. from the filesystem perspective"
	self subclassResponsibility
]

{ #category : #accessing }
CwMacApplication class >> calibre [
	^ CwMacApplication fromBundle: '/Applications/calibre.app' asFileReference.
]

{ #category : #accessing }
CwMacApplication class >> fromBundle: aFileReference [ 
	^ self new
		bundle: aFileReference;
		yourself.
]

{ #category : #accessing }
CwMacApplication class >> glamorousToolkit [
	^ self fromBundle: '/Applications/GlamorousToolkit/GlamorousToolkit.app' asFileReference.
]

{ #category : #accessing }
CwMacApplication class >> mail [
	<gtExample>
	| bundleFile result |
	bundleFile := '/Applications/Mail.app' asFileReference.
	result := CwMacApplication fromBundle: bundleFile.
	self assert: result bundle equals: bundleFile
]

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

{ #category : #accessing }
CwMacApplication >> bundle [
	^ bundle ifNil: [ bundle := self class bundle ]
]

{ #category : #accessing }
CwMacApplication >> bundle: aFileReference [ 
	bundle := aFileReference
]

{ #category : #'as yet unclassified' }
CwMacApplication >> delay: aDuration [ 

	self tellApplicationTo: 'delay ', aDuration seconds asString.
]

{ #category : #actions }
CwMacApplication >> isQuarantined [
	"For some of the implications of quarantine, see https://www.synack.com/blog/untranslocating-apps/"

	^ (Smalltalk tools shell new outputOf: 'xattr ', self bundle fullName surroundedByDoubleQuotes) includesSubstring: 'com.apple.quarantine'
	
	"Reference: 
		- https://derflounder.wordpress.com/2012/11/20/clearing-the-quarantine-extended-attribute-from-downloaded-applications/"
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

	Smalltalk tools shell new runExternally: 'sudo xattr -r -d com.apple.quarantine ', self bundle fullName surroundedByDoubleQuotes
	
	"
!References 
  - *https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra*
  - *https://apple.stackexchange.com/a/342403/9507*"
]
