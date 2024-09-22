Class {
	#name : #CwSMS,
	#superclass : #Object,
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : #ComputerWorld
}

{ #category : #'as yet unclassified' }
CwSMS >> displayStringOn: aStream [

	self rawDataAt: 'readable_date' 
		reader: [ :str | aStream << str ]
		ifAbsent: [].
		
	self isInbox
		ifTrue: [ aStream << ' from ' ]
		ifFalse: [ aStream << ' to ' ].
		
	self rawDataAt: 'contact_name' 
		reader: [ :str | aStream space; << str; << $: ]
		ifAbsent: [].
		
	self rawDataAt: 'body' 
		reader: [ :str | aStream space; << str; << $: ]
		ifAbsent: []
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
