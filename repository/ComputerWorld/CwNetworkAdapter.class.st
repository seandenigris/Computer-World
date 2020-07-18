Class {
	#name : #CwNetworkAdapter,
	#superclass : #Object,
	#instVars : [
		'ipAddress',
		'description',
		'usage',
		'speed'
	],
	#category : #'ComputerWorld-NAS'
}

{ #category : #accessing }
CwNetworkAdapter >> description [
	^ self maLazyFrom: self descriptionDescription
]

{ #category : #accessing }
CwNetworkAdapter >> description: aString [
	description := aString
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #description;
		yourself
]

{ #category : #accessing }
CwNetworkAdapter >> ipAddress [
	^ self maLazyFrom: self ipAddressDescription
]

{ #category : #accessing }
CwNetworkAdapter >> ipAddress: aString [
	ipAddress := aString
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> ipAddressDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #ipAddress;
		yourself
]

{ #category : #printing }
CwNetworkAdapter >> printOn: aStream [
	aStream
		nextPutAll: description;
		nextPutAll: ' (', speed asString, 'Gb/s)'
]

{ #category : #accessing }
CwNetworkAdapter >> speed [
	^ self maLazyFrom: self speedDescription
]

{ #category : #accessing }
CwNetworkAdapter >> speed: aNumber [
	speed := aNumber
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> speedDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #speed;
		comment: 'Gb/s';
		yourself
]

{ #category : #accessing }
CwNetworkAdapter >> usage [
	^ self maLazyFrom: self usageDescription
]

{ #category : #accessing }
CwNetworkAdapter >> usage: aString [
	usage := aString
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> usageDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #usage;
		default: ''; "prevent nil checks"
		yourself
]
