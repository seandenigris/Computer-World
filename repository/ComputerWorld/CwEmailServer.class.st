Class {
	#name : 'CwEmailServer',
	#superclass : 'CwServer',
	#instVars : [
		'forwarders'
	],
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'accessing' }
CwEmailServer >> forwarders [
	^ forwarders ifNil: [ forwarders := OrderedCollection new ]
]

{ #category : 'accessing' }
CwEmailServer >> gtGtSpotterForwardersFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Forwarders';
		items: [ self forwarders ];
		matchSubstrings
]

{ #category : 'forwarders - importing' }
CwEmailServer >> sitegroundForwardersFromClippedHTML [
	"Precondition: clipoard contains <tbody> HTML from Site Tool e.g. via a browser dev tool"

	| soup |
	soup := Soup fromString: Clipboard clipboardText asString.
	^ (soup // #tr) allButFirst asOrderedCollection collect: [ :e |
		CwEmailForwarder new
			alias: e children first p string;
			destination: e children second a string;
			yourself ].
]

{ #category : 'forwarders - importing' }
CwEmailServer >> sitegroundForwardersImport [

	self sitegroundForwardersFromClippedHTML reverse do: [ :new |
		self forwarders 
			detect: [ :existing | existing alias = new alias ]
			ifFound: [ :match | 
				match destination = new destination
					ifFalse: [ self notify: new alias, ' destination changed' ] ].
		self forwarders addFirst: new ].
]
