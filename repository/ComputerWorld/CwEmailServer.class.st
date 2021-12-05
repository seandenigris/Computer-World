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
CwEmailServer >> gtGtSpotterForwardersFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Forwarders';
		allCandidates: [ self forwarders ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7
]

{ #category : #'forwarders - importing' }
CwEmailServer >> importSitegroundForwardersFile: file [

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