Class {
	#name : #CwEmailForwarder,
	#superclass : #Object,
	#instVars : [
		'alias',
		'destination'
	],
	#category : #'ComputerWorld-Networking'
}

{ #category : #accessing }
CwEmailForwarder >> = rhs [

	^ self alias = rhs alias and: [ self destination = rhs destination ]
]

{ #category : #accessing }
CwEmailForwarder >> alias [
	^ alias
]

{ #category : #private }
CwEmailForwarder >> alias: email [
	alias := email
]

{ #category : #accessing }
CwEmailForwarder >> clipAlias [
	Clipboard clipboardText: self alias
]

{ #category : #accessing }
CwEmailForwarder >> clipAliasDescription [

	<magritteActionDescription>
	^ MAActionDescription new
		  action: #clipAlias;
		  gtIcon: BrGlamorousVectorIcons clipboard;
		  yourself
]

{ #category : #private }
CwEmailForwarder >> destination [
	^ destination
]

{ #category : #private }
CwEmailForwarder >> destination: email [
	destination := email
]

{ #category : #accessing }
CwEmailForwarder >> hash [

	^ self alias hash bitXor: self destination hash
]

{ #category : #accessing }
CwEmailForwarder >> printOn: aStream [
	aStream
		nextPutAll: alias;
		nextPutAll: ' -> ';
		nextPutAll: destination
]
