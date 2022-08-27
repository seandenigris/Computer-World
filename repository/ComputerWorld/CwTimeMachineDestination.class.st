Class {
	#name : #CwTimeMachineDestination,
	#superclass : #Object,
	#instVars : [
		'rawData'
	],
	#category : #'ComputerWorld-TimeMachine'
}

{ #category : #accessing }
CwTimeMachineDestination class >> all [
	| xmlString xml container |
	xmlString := CwTimeMachine destinationInfoCommand output.
	xml := XMLDOMParser parse: xmlString.
	xml removeAllFormattingNodes.
	container := xml // [ :node | (node isElementNamed: #dict) and: [ (node / #key) first innerXML = 'Destinations' ] ].
	^ container // #dict 
		collect: [ :destDict | self fromXml: destDict ]
		as: Bag.
]

{ #category : #accessing }
CwTimeMachineDestination class >> fromXml: destDict [
	| rawData keyString |
	rawData := Dictionary new.
	destDict nodes pairsDo: [ :k :v | 
		keyString := k innerXML.
		keyString := (keyString allSatisfy: #isUppercase)
			ifTrue: [ keyString asLowercase ]
			ifFalse: [ keyString uncapitalized ].
	rawData at: keyString asSymbol put: v innerXML ].
	^ self onRawData: rawData
]

{ #category : #accessing }
CwTimeMachineDestination class >> onRawData: aDictionary [
	^ self new
		rawData: aDictionary;
		yourself
]

{ #category : #accessing }
CwTimeMachineDestination >> gtViewRawDataOn: aView [
	<gtView>
	
	^ aView forward
		title: 'Raw Data';
		priority: 50;
		object: [ self rawData ];
		view: #gtItemsFor:
]

{ #category : #accessing }
CwTimeMachineDestination >> id [
	
	^ self rawData at: #id ifAbsent: [ nil ]
]

{ #category : #accessing }
CwTimeMachineDestination >> kind [
	
	^ self rawData at: #kind ifAbsent: [ nil ]
]

{ #category : #accessing }
CwTimeMachineDestination >> lastDestination [
	
	^ self rawData at: #lastDestination ifAbsent: [ nil ]
]

{ #category : #accessing }
CwTimeMachineDestination >> name [
	
	^ self rawData at: #name ifAbsent: [ nil ]
]

{ #category : #accessing }
CwTimeMachineDestination >> printOn: aStream [
	self name ifNotNil: [ :str | aStream nextPutAll: str ].
	self url ifNotNil: [ :obj | aStream nextPutAll: ' @ '; print: obj ].
	self kind = 'Local' ifTrue: [ aStream nextPutAll: ' (Local)' ].
]

{ #category : #private }
CwTimeMachineDestination >> rawData [
	^ rawData
]

{ #category : #private }
CwTimeMachineDestination >> rawData: aDictionary [
	rawData := aDictionary
]

{ #category : #accessing }
CwTimeMachineDestination >> server [
	^ CwNetworkDevice db 
		detect: [ :e | e adapters anySatisfy: [ :a | a ipAddress asString = self url host ] ]
		ifNone: [ nil ]
]

{ #category : #'starting/stopping' }
CwTimeMachineDestination >> startBackup [
	^ CwTimeMachine startBackupToCommand
		argumentAt: #destinationID put: self id;
		run
]

{ #category : #'starting/stopping' }
CwTimeMachineDestination >> stopBackup [
	"Stop whatever backup is currently running (even if to another destination). There really is no command to stop a specific backup, apparently because there would only ever be one running. This is here for convenience only as it seems natural to look for it here"
	^ CwTimeMachine stopBackupCommand run
]

{ #category : #accessing }
CwTimeMachineDestination >> url [
	
	^ self rawData 
		at: #url 
		ifPresent: [ :str | str asUrl ]
		ifAbsent: [ nil ]
]
