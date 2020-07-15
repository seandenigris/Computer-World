Class {
	#name : #CwUnixUserEntity,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : #'ComputerWorld-Unix'
}

{ #category : #accessing }
CwUnixUserEntity >> id [
	^ self maLazyFrom: self idDescription
]

{ #category : #accessing }
CwUnixUserEntity >> id: aNumber [
	id := aNumber
]

{ #category : #'magritte-accessing' }
CwUnixUserEntity >> idDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #id;
		priority: 200;
		yourself
]

{ #category : #accessing }
CwUnixUserEntity >> name [
	^ self maLazyFrom: self nameDescription
]

{ #category : #accessing }
CwUnixUserEntity >> name: aString [
	name := aString
]

{ #category : #'magritte-accessing' }
CwUnixUserEntity >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		priority: 100;
		yourself
]

{ #category : #printing }
CwUnixUserEntity >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' (';
		print: id;
		nextPut: $)
]
