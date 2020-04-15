"
The first thing to do is to set up a shared secret in BTT so that nefarious parties can't script it. Fill in your secret in the BTT settings and then in the snippet below:

	CwBetterTouchTool sharedSecret: 'my secret'
	
You may have to quit and relauch BTT for the setting to take effect.
"
Class {
	#name : #CwBetterTouchTool,
	#superclass : #Object,
	#instVars : [
		'isTestMode'
	],
	#classVars : [
		'Actions',
		'SharedSecret'
	],
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwBetterTouchTool class >> actions [
	^ Actions ifNil: [ Actions := OrderedCollection new ]
]

{ #category : #accessing }
CwBetterTouchTool class >> actions: anObject [
	Actions := anObject
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool class >> addAction: aString [ 
	| action |
	action := NeoJSONReader fromString: aString.
	^ self actions add: action
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool class >> detectActionNamed: aString [
	^ self actions detect: [ :e | (e at: 'BTTPredefinedActionName') = aString ]
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool class >> sharedSecret [
	^ SharedSecret
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool class >> sharedSecret: aString [
	SharedSecret := aString
]

{ #category : #accessing }
CwBetterTouchTool >> isTestMode [
	^ isTestMode ifNil: [ false ].
]

{ #category : #accessing }
CwBetterTouchTool >> isTestMode: anObject [
	isTestMode := anObject
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool >> namedTriggers [
	^ #('Play_Music')
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool >> pullTriggerNamed: aString [
	"Example:
		CwBetterTouchTool new pullTriggerNamed: 'Play_Music'
	Reference: https://docs.bettertouchtool.net/docs/1103_custom_url_scheme.html"
	
	| url |
	url := 'btt://trigger_named/' asUrl
		queryAt: 'trigger_name' put: aString;
		yourself.
	self request: url
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool >> request: url [
	| command |
	self class sharedSecret ifNotNil: [ :secret | url queryAt: 'shared_secret' put: secret ].
	command := 'open ', url asString surroundedByDoubleQuotes.
	self isTestMode ifTrue: [ ^ command ].
	Smalltalk tools shell new run: command.
]

{ #category : #'as yet unclassified' }
CwBetterTouchTool >> triggerAction: json [
	"Example:
		CwBetterTouchTool new triggerAction: 
	Reference: https://docs.bettertouchtool.net/docs/1103_custom_url_scheme.html"
	
	| url jsonString |
	jsonString := NeoJSONWriter toString: json.
	url := 'btt://trigger_action/' asUrl
		queryAt: 'json' put: jsonString;
		yourself.
	^ self request: url
]
