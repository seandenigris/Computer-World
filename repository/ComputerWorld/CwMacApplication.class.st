"
There are two ways to use me.

!Generic Application Mode
This may be how most applications start out. There is no behavior yet to justify a subclass, and we may never come back to implement any, so we ${example:CwMacApplication class>>#mail|previewShow=true}$ create an instance like so:
and we're able to do things that are universal to all applications.
!!Quarantine on Mac
In certain circumstances, MacOS places downloaded apps in ""quarantine"". One of the consequences that can cause confusion is that the app is then copied to a read-only DMG in another location and run from there.  This can stymy code that relies on the image or VM being in a particular place. I provide the ability to check via ${method:CwMacApplication>>#isQuarantined|label=isQuarantined}$ and fix via ${method:CwMacApplication>>#unquarantine|label=unquarantine}$.
!Application with Specific Behavior
Once we begin to implement features unique to the app, a subclass is in order. Here are some already available:
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

{ #category : #examples }
CwMacApplication class >> exampleGeneric [
	<gtExample>
	| result |
	result := self mail.
	self assert: result class equals: CwMacApplication.
	self assert: result bundle equals: '/Applications/Mail.app' asFileReference.
	^ result
]

{ #category : #examples }
CwMacApplication class >> exampleSubclassExists [
	<gtExample>
	| result |
	result := CwMacApplication fromBundle: '/Applications/OBS.app' asFileReference.
	self assert: result class equals: CwOBS.
	^ result
]

{ #category : #accessing }
CwMacApplication class >> fromBundle: aFileReference [
	^ self allSubclasses
		detect: [ :cls | cls bundle = aFileReference ]
		ifFound: [ :cls | cls new ]
		ifNone: [ self new
				bundle: aFileReference;
				yourself ]
]

{ #category : #accessing }
CwMacApplication class >> glamorousToolkit [
	^ self fromBundle: '/Applications/GlamorousToolkit/GlamorousToolkit.app' asFileReference.
]

{ #category : #'instance creation' }
CwMacApplication class >> mail [
	| bundleFile |
	bundleFile := '/Applications/Mail.app' asFileReference.
	^ CwMacApplication fromBundle: bundleFile.
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

	^ self bundle base.
]

{ #category : #accessing }
CwMacApplication >> applicationNameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #applicationName;
		priority: 100;
		yourself.
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
	SuGenericUnixCommand new
		template: 'sudo xattr -r -d com.apple.quarantine {bundle}';
		argumentSource: { #bundle -> self bundle } asDictionary;
		runInTerminal.

	"
!References 
  - *https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra*
  - *https://apple.stackexchange.com/a/342403/9507*"
]
