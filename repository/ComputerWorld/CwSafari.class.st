Class {
	#name : #CwSafari,
	#superclass : #Object,
	#category : 'ComputerWorld-Mac'
}

{ #category : #private }
CwSafari >> applescriptTell: aString [

	| command |
	"Adapted from https://apple.stackexchange.com/a/141721/9507. Didn't work without changing to Unix line endings, probably related to the HEREDOC"
	command := 'osascript <<EOD
tell application "Safari"
{1}
end tell
EOD' withUnixLineEndings format: { aString }.

	"Ideally this would not wait, but the implementation of OSShell #run: doesn't work with HEREDOCs"
	self shell runAndWait: command
]

{ #category : #opening }
CwSafari >> open: aUrl [

	self shell open: aUrl
]

{ #category : #opening }
CwSafari >> openInFront: aUrl [

	| command |
	command := 'activate
set the URL of the front document to "{1}"' format: { aUrl asString }.
	self applescriptTell: command.
	
	"Adapted from https://stackoverflow.com/a/7016686/424245"
]

{ #category : #opening }
CwSafari >> openInNewWindow: aUrl [
	"Window will open in the current space on top of any others"

	| command |
	"Adapted from https://apple.stackexchange.com/a/141721/9507"
	command := 'activate
make new document with properties \{URL:"{1}"\}' format: { aUrl asString }.
	self applescriptTell: command
]

{ #category : #private }
CwSafari >> shell [

	^ Smalltalk tools shell new
]
