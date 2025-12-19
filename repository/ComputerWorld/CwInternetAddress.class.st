Class {
	#name : 'CwInternetAddress',
	#superclass : 'Object',
	#instVars : [
		'rawAddress'
	],
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'abstract' }
CwInternetAddress class >> byteToString: anInteger [
	self subclassResponsibility
]

{ #category : 'abstract' }
CwInternetAddress class >> displaySeparator [
	self subclassResponsibility
]

{ #category : 'instance creation' }
CwInternetAddress class >> fromInteger: anInteger [
	^ self new
			rawAddress: anInteger;
			yourself
]

{ #category : 'instance creation' }
CwInternetAddress class >> fromString: aString [
	^ self fromInteger: (self stringToRawAddress: aString)
]

{ #category : 'utilities' }
CwInternetAddress class >> rawAddressToString: anInteger [

	^ String streamContents: [ :s |
		(anInteger asByteArrayOfSize: self sizeInBytes) 
			do: [ :byte | s nextPutAll: (self byteToString: byte) ]
			separatedBy: [ s nextPut: self displaySeparator ] ]
]

{ #category : 'abstract' }
CwInternetAddress class >> sizeInBytes [
	self subclassResponsibility
]

{ #category : 'abstract' }
CwInternetAddress class >> stringToByte: aString [
	self subclassResponsibility
]

{ #category : 'utilities' }
CwInternetAddress class >> stringToRawAddress: aString [

	| byteStrings bytes |
	byteStrings := aString splitOn: self displaySeparator.
	bytes := byteStrings collect: [ :e | (self stringToByte: e) ].
	^ (ByteArray newFrom: bytes) asInteger
]

{ #category : 'comparing' }
CwInternetAddress >> = rhs [
	^ self species = rhs species and: [ self rawAddress = rhs rawAddress ]
]

{ #category : 'accessing' }
CwInternetAddress >> asByteArray [
	^ self rawAddress asByteArray
]

{ #category : 'comparing' }
CwInternetAddress >> hash [
	^ self rawAddress hash
]

{ #category : 'printing' }
CwInternetAddress >> printOn: aStream [
	self printOn: aStream separatedBy: self class displaySeparator
]

{ #category : 'printing' }
CwInternetAddress >> printOn: aStream separatedBy: aCharacter [
	self rawAddress asByteArray 
		do: [ :byte | aStream nextPutAll: (self class byteToString: byte) ]
		separatedBy: [ aStream nextPut: aCharacter ]
]

{ #category : 'accessing' }
CwInternetAddress >> rawAddress [
	^ self maLazyInstVarUsing: self rawAddressDescription
]

{ #category : 'accessing' }
CwInternetAddress >> rawAddress: aNumber [
	rawAddress := aNumber
]

{ #category : 'magritte-accessing' }
CwInternetAddress >> rawAddressDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #rawAddress;
		default: 0;
		yourself
]
