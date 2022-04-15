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
CwEmailForwarder >> alias [
	^ alias
]

{ #category : #accessing }
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

{ #category : #accessing }
CwEmailForwarder >> destination: email [
	destination := email
]

{ #category : #accessing }
CwEmailForwarder >> printOn: aStream [
	aStream
		nextPutAll: alias;
		nextPutAll: ' -> ';
		nextPutAll: destination
]
