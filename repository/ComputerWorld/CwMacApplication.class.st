"
# Getting Started - Usage Modes
There are two ways to use me.
## Generic Application Mode
This may be how most applications start out. There is no behavior yet to justify a subclass, and we may never come back to implement any, so we create an instance {{gtMethod:CwMacApplication class>>#mail|expanded=true|label='like so'}}:
and we're able to do things that are universal to all applications.
## Application with Specific Behavior
Once we begin to implement features unique to the app, a subclass is in order. Here are some already available:
```language=smalltalk
CwMacApplication allSubclasses
```

A subclass should declare where the app lives. For most apps, just implement class-side `#bundleBasename` and it will be looked up in the default locations (see {{gtMethod:CwMacApplication class>>#bundleParent}}. For other locations, implement class-side `#bundleParent` as well returning an FS resolvable.

# Features
## Quarantine on Mac
In certain circumstances, MacOS places downloaded apps in ""quarantine"". One of the consequences that can cause confusion is that the app is then copied to a read-only DMG in another location and run from there.  This can stymie code that relies on the image or VM being in a particular place. I provide the ability to check via {{gtMethod:CwMacApplication>>#isQuarantined|label=isQuarantined}} and fix via {{gtMethod:CwMacApplication>>#unquarantine|label=unquarantine}}.

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
	"Returns a resolveable FS artifact; this creates a little confusion in other code because sometimes you care about the full path (e.g. when connecting to an app that is known to be installed at a certain location) and sometimes you care about the filename only (e.g. is this bundle file for this particular app, regardless of where it is on disk"
	^ self bundleParent / self bundleBasename
]

{ #category : #accessing }
CwMacApplication class >> bundleBasename [
	"Subclasses should override to e.g. allow matching a bundle file to the correct (sub)class."
	self subclassResponsibility
]

{ #category : #accessing }
CwMacApplication class >> bundleParent [
	"Override in subclass if location not listed. Return a resolveable FS artifact"
	^ { 
		'/System/Applications' asFileReference.
		'/Applications' asFileReference } detect: [ :e | e directoryNames includes: self bundleBasename ]
]

{ #category : #'instance creation' }
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
CwMacApplication class >> executable [
	| folder files |
	folder := self bundle / 'Contents' / 'MacOS'.
	files := folder files.
	self assert: files size = 1. "Domain assumption"
	^ files first.
]

{ #category : #accessing }
CwMacApplication class >> fromBundle: aFileReference [
	^ self allSubclasses
		detect: [ :cls | cls isAbstract not and: [ cls bundleBasename = aFileReference basename ] ]
		ifFound: [ :cls | 
			| instance |
			instance := cls new.
			instance bundle ~= aFileReference ifTrue: [ instance bundle: aFileReference ]. "See class-side #bundle method comment"
			instance ]
		ifNone: [ self new
				bundle: aFileReference;
				yourself ]
]

{ #category : #'instance creation' }
CwMacApplication class >> glamorousToolkit [
	^ self fromBundle: '/Applications/GlamorousToolkit/GlamorousToolkit.app' asFileReference.
]

{ #category : #testing }
CwMacApplication class >> isSystem [
	"As of 10.5 Catalina, apps that are part of macOS and are located in the read-only /System/Applications/ as opposed to /Applications"
	^ self isAbstract not and: [ '/System/Applications/' asFileReference directoryNames includes: self bundle basename ]
]

{ #category : #'process management' }
CwMacApplication class >> killAll [
	SuGenericUnixCommand new
		template: 'killall {processName}';
		argumentAt: #processName put: self executable basename;
		run.
]

{ #category : #'process management' }
CwMacApplication class >> launch [
	self bundle open.
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

{ #category : #'process management' }
CwMacApplication class >> relaunch [
	self killAll.
	[ "Give enough time to shut down without freezing the image"
		3 seconds wait.
		self launch ] fork
]

{ #category : #actions }
CwMacApplication >> activate [

	self tellApplicationTo: 'activate'.
]

{ #category : #accessing }
CwMacApplication >> applicationName [

	^ self bundle base.
]

{ #category : #'Magritte-accessing' }
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

{ #category : #actions }
CwMacApplication >> delay: aDuration [ 

	self tellApplicationTo: 'delay ', aDuration seconds asString.
]

{ #category : #testing }
CwMacApplication >> isQuarantined [
	"For some of the implications of quarantine, see https://www.synack.com/blog/untranslocating-apps/"

	^ (Smalltalk tools shell new outputOf: 'xattr ', self bundle fullName surroundedByDoubleQuotes) includesSubstring: 'com.apple.quarantine'
	
	"Reference: 
		- https://derflounder.wordpress.com/2012/11/20/clearing-the-quarantine-extended-attribute-from-downloaded-applications/"
]

{ #category : #accessing }
CwMacApplication >> open: aFileOrResource [
	aFileOrResource suOpenWith: self
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
		template: 'xattr -r -d com.apple.quarantine {bundle}';
		argumentSource: { #bundle -> self bundle } asDictionary;
		asRoot;
		run.

	"
!References 
  - *https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra*
  - *https://apple.stackexchange.com/a/342403/9507*"
]
