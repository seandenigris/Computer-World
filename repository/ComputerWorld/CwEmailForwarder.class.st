Class {
	#name : 'CwEmailForwarder',
	#superclass : 'Object',
	#instVars : [
		'alias',
		'destination'
	],
	#category : 'ComputerWorld-NAS'
}

{ #category : 'accessing' }
CwEmailForwarder >> alias: email [
	alias := email
]

{ #category : 'accessing' }
CwEmailForwarder >> destination: email [
	destination := email
]

{ #category : 'accessing' }
CwEmailForwarder >> printOn: aStream [
	aStream
		nextPutAll: alias;
		nextPutAll: ' -> ';
		nextPutAll: destination
]
