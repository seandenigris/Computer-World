Class {
	#name : #CwSMS,
	#superclass : #Object,
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : #ComputerWorld
}

{ #category : #'as yet unclassified' }
CwSMS class >> allFromXML: aFileReference [
	"With my return value, try `smses groupedBy: #contactName`"

	| result parser |
	self flag: 'MMSes will be ignored'.
	parser := XMLDOMParser onFileNamed: aFileReference fullName.
	result := parser
		documentReadLimit: aFileReference size * 5; "trial and error"
		parseDocument.
	^ result // 'sms'
			collect: [ :smsNode | self fromDictionary: smsNode attributes ]
			as: OrderedCollection.
			
	"Implementation note: SMSes seem to all be attributes only, but MMSes `hasStringNodes`, `hasContentNodes` and `elements isNotEmpty`"
]

{ #category : #'as yet unclassified' }
CwSMS >> body [

	^ self 
		rawDataAt: 'body' 
		ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
CwSMS >> bodyDescription [
	<magritteDescription>
	
	^ MAMemoDescription new 
		accessor: #body;
		priority: 300;
		yourself
]

{ #category : #'as yet unclassified' }
CwSMS >> contactName [

	^ self 
		rawDataAt: 'contact_name' 
		ifAbsent: [ nil ].
]

{ #category : #'as yet unclassified' }
CwSMS >> contactNameDescription [
	<magritteDescription>
	
	^ MAStringDescription new 
		accessor: #contactName;
		priority: 200;
		yourself
]

{ #category : #'as yet unclassified' }
CwSMS >> dateReadable [

	^ self 
		rawDataAt: 'readable_date' 
		ifAbsent: [ nil ].
]

{ #category : #'as yet unclassified' }
CwSMS >> dateReadableDescription [
	<magritteDescription>
	
	^ MAStringDescription new 
		accessor: #dateReadable;
		priority: 100;
		yourself
]

{ #category : #'as yet unclassified' }
CwSMS >> displayStringOn: aStream [

	self dateReadable ifNotNil: [ :str | aStream << str ].
		
	self isInbox
		ifTrue: [ aStream << ' from ' ]
		ifFalse: [ aStream << ' to ' ].
		
	self contactName ifNotNil: [ :str | aStream space; << str; << $: ].
		
	self body ifNotNil: [ :str | aStream space; << str; << $: ]
]

{ #category : #'as yet unclassified' }
CwSMS >> isInbox [

	^ self type = 1
]

{ #category : #'as yet unclassified' }
CwSMS >> isSent [

	^ self type = 2
]

{ #category : #'as yet unclassified' }
CwSMS >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #'as yet unclassified' }
CwSMS >> type [
	
	^ self rawDataAt: 'type' 
		reader: #asNumber
		ifAbsent: [ nil ].
		
	"From stackoverflow (https://stackoverflow.com/a/9397818):
MESSAGE_TYPE_ALL    = 0;
MESSAGE_TYPE_INBOX  = 1;
MESSAGE_TYPE_SENT   = 2;
MESSAGE_TYPE_DRAFT  = 3;
MESSAGE_TYPE_OUTBOX = 4;
MESSAGE_TYPE_FAILED = 5; // for failed outgoing messages
MESSAGE_TYPE_QUEUED = 6; // for messages to send later"
]
