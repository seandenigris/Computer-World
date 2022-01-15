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
	| xmlString xml container destinations rawData keyString |
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
	self url ifNotNil: [ :str | aStream nextPutAll: ' @ '; nextPutAll: str ].
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
CwTimeMachineDestination >> url [
	
	^ self rawData at: #url ifAbsent: [ nil ]
]
