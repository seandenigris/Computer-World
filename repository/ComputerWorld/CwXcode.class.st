Class {
	#name : #CwXcode,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwXcode class >> install [
	<script>

	| script command |
	script := 'tell application "App Store" to activate'.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.
]

{ #category : #'as yet unclassified' }
CwXcode class >> installCommandLineTools [
	"Requires interactivity to accept the license agreement
	From: https://apple.stackexchange.com/a/254381"
	
	'xcode-select --install'
]

{ #category : #'as yet unclassified' }
CwXcode class >> purpose [
	"- viewing/editing plist files"
]
