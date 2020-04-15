Class {
	#name : #CwOBS,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwOBS class >> bundle [
	^ '/Applications/OBS.app' asFileReference
]

{ #category : #accessing }
CwOBS class >> viewRemote [
	<script>
	CwOBSRemote new openWithSpec maximize.
]

{ #category : #'as yet unclassified' }
CwOBS >> sendHotkey: aString [

	| template command |
	template := 'use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

tell application "System Events"
	set frontAppID to bundle identifier of first process whose frontmost is true
	tell application "OBS" to activate
	keystroke "{key}"
end tell
activate application id frontAppID
--delay 1
--tell application "System Events" to keystroke "			" using command down'.
	command := template format: { #key -> aString } asDictionary.
	Applescript doIt: command.
	
	"Implementation note: the frontAppID method of saving and restoring the active application came from https://stackoverflow.com/a/44057495/424245 . The final activate needed to be outside of the tell block or it didn't work"
]
