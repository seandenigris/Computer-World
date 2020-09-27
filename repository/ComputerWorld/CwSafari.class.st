"
!Messages / API
-${method:name=CwSafari>>#videoSpeed:|label='#videoSpeed:'}$ - Set the speed of all HTML5 ==<video>== elements. 1 is regular speed. See the ==playbackRate== property *docs >https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/playbackRate* for more info. Assumes Safari 'document 1', which will be the topmost (in the current Mac Space if there is one). Here's an example usage: ${example:CwSafari class>>#exampleVideoSpeedDouble}$
"
Class {
	#name : #CwSafari,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

{ #category : #examples }
CwSafari class >> exampleVideoSpeedDouble [
	<gtExample>
	CwSafari new videoSpeed: 2.
]

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

{ #category : #'video control' }
CwSafari >> videoSpeed: aNumber [
	<apiDocumentation>
	<description: 'Set the speed of all HTML5 ==<video>== elements. 1 is regular speed. See the ==playbackRate== property *docs >https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/playbackRate* for more info. Assumes Safari ''document 1'', which will be the topmost (in the current Mac Space if there is one)'>
	
	| js script |
	js := 'var ta=document.getElementsByTagName(''video''); 
		for(var i=0;i<ta.length;i++) {ta[i].playbackRate=', aNumber asString, '};'.
	script := 'tell application "Safari" to do JavaScript "', js, '" in document 1'.
	Applescript doIt: script.
	
	"! Implementation note
Adapted from *this Quora answer>https://www.quora.com/Is-there-any-way-to-watch-Facebook-videos-at-double-the-speed*. There is a slight variation recommended *on SO>https://stackoverflow.com/a/44158819/424245* using querySelectorAll instead of getElementsByTagName if this ever must be revisited."
]
