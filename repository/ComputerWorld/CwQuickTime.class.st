Class {
	#name : 'CwQuickTime',
	#superclass : 'CwMacApplication',
	#category : 'ComputerWorld-Mac'
}

{ #category : 'accessing' }
CwQuickTime class >> bundleBasename [
	^ 'QuickTime Player.app'
]

{ #category : 'private' }
CwQuickTime >> applicationName [

	^ 'QuickTime Player'.
]

{ #category : 'accessing' }
CwQuickTime >> currentCD [
	self shouldBeImplemented
]

{ #category : 'actions' }
CwQuickTime >> isPlaying: aPlayable [

	"If conflices arise because of multiple files with the same file name, a better check would be POSIX path of file of document, but we may have to loop manually to find it (I don't think you can use the condition clause)"
	^ self tellApplicationTo: 'get playing of first document whose name is ', aPlayable file basename surroundedByDoubleQuotes.
]

{ #category : 'private' }
CwQuickTime >> isPlayingDocument: anIndex [

	^ (self tellApplicationTo: 'get playing of document ', anIndex asString).
]

{ #category : 'actions' }
CwQuickTime >> nameOfFirstDocument [

	^ self tellApplicationTo: 'get name of first document'.
]

{ #category : 'actions' }
CwQuickTime >> open: aFileReference [

	super open: aFileReference.
	self waitUntilLoaded: aFileReference.
	
		"Implementation note: Opening files in QT via Applescript is ridiculously buggy. Windows never appear, the running app doesn't appear in application switching... So the best thing to do is to just use the open CLI.
	
	If Apple's 'It Just Works' policy applied to power users, we would just say:
		self tellApplicationTo: 'open ', aFileDirectoryEntry asStringForCLI.
			which can take either a POSIX or HFS path."
]

{ #category : 'actions' }
CwQuickTime >> openFirstTrackOfCurrentlyInsertedCD [
	"Implementation rationale: QuickTime Player's Applescript support for finding out info about media in drives is non-existant, so we lean on iTunes here"

	| firstTrackPath trackFile |
	firstTrackPath := Applescript doIt: '
		tell application "iTunes"
			set cd to first source whose kind contains "CD"
			set firstTrackFile to get location of first track of cd
		end tell
		tell application "Finder" to set firstTrackPath to get POSIX path of firstTrackFile'.
	
	trackFile := DirectoryEntry at: firstTrackPath.
	self open: trackFile.
]

{ #category : 'actions' }
CwQuickTime >> pause [

	self tellApplicationTo: 'pause document 1'.
]

{ #category : 'actions' }
CwQuickTime >> play [

	self tellApplicationTo: 'play document 1'.
]

{ #category : 'actions' }
CwQuickTime >> play: aCD [ 
	self shouldBeImplemented
]

{ #category : 'actions' }
CwQuickTime >> playCD [

	self openFirstTrackOfCurrentlyInsertedCD. "This is only necessary the first time, but it's working, and I have more important things to do, so f**k it'"
	"Implementation rationale: Whether the limit is of QuickTime or its Applescript interface, 'document 1' is returned before it is ready to play, so we can't query the document.  So we just keep trying to play it until it plays, with not much lost by a few repeated attempts."
	[ self isPlayingDocument: 1 ] whileFalse: [ self play ].
]

{ #category : 'as yet unclassified' }
CwQuickTime >> playSpeedFactor [

	^ (self tellApplicationTo: 'get rate of document 1') asNumber.
]

{ #category : 'as yet unclassified' }
CwQuickTime >> playSpeedFactor: aNumber [

	^ self tellApplicationTo: 'set rate of document 1 to ',  aNumber asString.
]

{ #category : 'actions' }
CwQuickTime >> position [

	^ Duration seconds: (self tellApplicationTo: 'get current time of document 1') asNumber.
]

{ #category : 'actions' }
CwQuickTime >> position: aDuration [

	self tellApplicationTo: 'set current time of document 1 to ', aDuration asSeconds asString, '.', aDuration nanoSeconds asString.
]

{ #category : 'actions' }
CwQuickTime >> skipAhead: aNumberOfSeconds [ 

	self skipBy: aNumberOfSeconds.
]

{ #category : 'actions' }
CwQuickTime >> skipBack: aNumberOfSeconds [

	self skipBy: -1 * aNumberOfSeconds.
]

{ #category : 'private' }
CwQuickTime >> skipBy: aNumberOfSeconds [ 

	| command position commandTemplate |
	position := 'current time of document 1'.
	commandTemplate := '
		set {1} to (({1}) + {2})
		play document 1'. "We play after skipping because QuickTime seems to have a bug where it intermittently stops playing after the position is changed."
	command := commandTemplate format: { position. aNumberOfSeconds }.
	self tellApplicationTo: command.
]

{ #category : 'private' }
CwQuickTime >> waitUntilLoaded: aFileReference [
	"Files opened in QT often take several seconds to load. Sending an event to a document before it is fully loaded causes an error"

	| scriptTemplate script |
	scriptTemplate := '
		try
			get current time of document {1}
			return true
		end try
		false'.
	script := scriptTemplate format: { aFileReference basename surroundedByDoubleQuotes }.
	[ self tellApplicationTo: script ] whileFalse: [ 0.5 seconds asDelay wait ].
]
