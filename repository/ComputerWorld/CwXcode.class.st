Class {
	#name : 'CwXcode',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwXcode class >> install [
	<script>

	| script command |
	script := 'tell application "App Store" to activate'.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.
]

{ #category : 'as yet unclassified' }
CwXcode class >> installCommandLineTools [
	"Requires interactivity to accept the license agreement
	From: https://apple.stackexchange.com/a/254381"
	
	'xcode-select --install'
]

{ #category : 'as yet unclassified' }
CwXcode class >> loadInMojave [
	UIManager default alert: 'Last compatible version is 11.3.1 per https://stackoverflow.com/questions/61013626/how-to-run-xcode-11-4-on-macos-mojave-10-14-6'.
	WebBrowser openOn: 'https://developer.apple.com/download/more/?&q=xcode' asUrl
]

{ #category : 'as yet unclassified' }
CwXcode class >> purpose [
	"- viewing/editing plist files"
]

{ #category : 'as yet unclassified' }
CwXcode class >> sbGenerateHeaderFileFor: applicationPath [
	"From https://stackoverflow.com/a/5302099/424245"
	'sdef /path/to/application.app | sdp -fh --basename applicationName'
	
]

{ #category : 'as yet unclassified' }
CwXcode class >> sdef: applicationPath [
	"Example
		self sdef: '/Applications/iTunes.app/'
	"
	| template command |
	template := 'sdef "{applicationPath}"'.
	^ command := template format: { #applicationPath -> applicationPath } asDictionary.
	
]
