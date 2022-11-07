Class {
	#name : #CwEmailServer,
	#superclass : #CwServer,
	#instVars : [
		'forwarders'
	],
	#category : #'ComputerWorld-Networking'
}

{ #category : #accessing }
CwEmailServer >> forwarders [
	^ forwarders ifNil: [ forwarders := OrderedCollection new ]
]

{ #category : #accessing }
CwEmailServer >> gtGtSpotterForwardersFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Forwarders';
		items: [ self forwarders ];
		matchSubstrings
]

{ #category : #'forwarders - importing' }
CwEmailServer >> sitegroundForwardersImportClippedHTML [
	"Precondition: clipoard contains HTML from Site Tool e.g. via a browser dev tool"

	| soup fCol |
	soup := Soup fromString: Clipboard clipboardText asString.
	fCol := (soup // #tr) allButFirst asOrderedCollection collect: [ :e |
		CwEmailForwarder new
			alias: e children first div p string;
			destination: e children second a string;
			yourself ].
	self forwarders addAllFirst: fCol
]

{ #category : #'forwarders - importing' }
CwEmailServer >> sitegroundForwardersImportFile: file [

	"file - page source from Site Tool"

	| soup fCol |
	soup := Soup fromString: file contents.
	fCol := (soup // #tr) allButFirst asOrderedCollection collect: [ :e |
		CwEmailForwarder new
			alias: e children first div p string;
			destination: e children second a string;
			yourself ].
	self forwarders addAll: fCol
]
