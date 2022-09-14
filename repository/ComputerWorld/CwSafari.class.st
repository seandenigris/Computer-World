"
# Messages / API
- {{gtMethod:name=CwSafari>>#videoSpeed:|label='#videoSpeed:'}} - Set the speed of all HTML5 `<video>` elements. 1 is regular speed. See the `playbackRate` property [docs ](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/playbackRate) for more info. Assumes Safari 'document 1', which will be the topmost (in the current Mac Space if there is one). Here's an example usage: {{gtExample:CwSafari class>>#exampleVideoSpeedDouble}}

"
Class {
	#name : #CwSafari,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwSafari class >> bundleBasename [
	^ 'Safari.app'
]

{ #category : #examples }
CwSafari class >> exampleVideoSpeedDouble [
	<gtExample>
	CwSafari new videoSpeed: 2.
]

{ #category : #private }
CwSafari >> applescriptTellTo: aString [

	^ self applescriptTellTo: aString do: []
]

{ #category : #private }
CwSafari >> applescriptTellTo: aString do: aBlock [

	| as |
	as := Applescript new
		targetApplication: 'Safari';
		template: aString;
		yourself.
		
	aBlock cull: as.
	
	^ as output
]

{ #category : #scripting }
CwSafari >> doJavascript: aSuJSScript [
	<description: 'Assumes Safari ''document 1'', which will be the topmost (in the current Mac Space if there is one)'>
	
	^ self doJavascript: aSuJSScript in: 'document 1'
]

{ #category : #scripting }
CwSafari >> doJavascript: aSuJSScript in: aDocumentOrTab [
	"
	- script can only be one line. Possible workarounds would be to wrap in an anonymous function, but then you'd have to explicitly return to get a value back; if interested in implementing that, see https://www.geeksforgeeks.org/javascript-anonymous-functions/
	- All the wrapper code is needed because, for some reason, bools do not seem to get returned in macOS 12.0.1 on M1; see https://stackoverflow.com/q/70425709
	- AS errors don't return; maybe on stderr?"
	
	<apiDocumentation>
	
	| applescriptTemplate jsContents wrappedJS |
	jsContents := aSuJSScript string  copyReplaceAll: '"' with: '\"'.
	
	wrappedJS := 'try {
	var jsResult = ', jsContents, ';
	
		switch (jsResult) {
	case true:
		jsResult = ''js2as-true'';
		break;
	case false:
		jsResult = ''js2as-false'';
	}
jsResult
}
catch(err) {
''js2as-error'' + err.message
}'.

	applescriptTemplate := 'set result to do JavaScript "{js}" in {documentOrTab}

	if (result = "js2as-true") then
		return true
	else if (result = "js2as-false") then
		return false
	else if (result starts with "js2as-error") then
		set errMsg to text 12 thru -1 of result
		error errMsg
		--return result
	else
		return result
	end if'.

	^ Applescript new
		tell: 'Safari';
		template: applescriptTemplate;
		argumentAt: #js put: wrappedJS;
		argumentAt: #documentOrTab put: aDocumentOrTab;
		output.
]

{ #category : #accessing }
CwSafari >> isJavaScriptFromAppleEventsEnabled [
	^ SuGenericUnixCommand new
		template: '/usr/bin/defaults read com.apple.Safari AllowJavaScriptFromAppleEvents';
		"outputDecoder: [ :str | str trimBoth = '1' ];"
		output
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
	self applescriptTellTo: command.
	
	"Adapted from https://stackoverflow.com/a/7016686/424245"
]

{ #category : #opening }
CwSafari >> openInNewWindow: aUrl [
	"Window will open in the current space on top of any others"

	| command |
	"Adapted from https://apple.stackexchange.com/a/141721/9507"
	command := 'activate
make new document with properties \{URL:"{url}"\}'.
	self 
		applescriptTellTo: command 
		do: [ :as | as argumentAt: #url put: aUrl asString ]
]

{ #category : #private }
CwSafari >> shell [

	^ Smalltalk tools shell new
]

{ #category : #'video control' }
CwSafari >> videoSpeed: aNumber [
	<apiDocumentation>
	
	| js |
	js := SuJSScript htmlVideoSpeed
		argumentAt: #videoSpeed put: aNumber;
		yourself.
	self doJavascript: js
]
