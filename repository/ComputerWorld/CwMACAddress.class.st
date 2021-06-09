Class {
	#name : #CwMACAddress,
	#superclass : #CwInternetAddress,
	#category : #'ComputerWorld-Core'
}

{ #category : #utilities }
CwMACAddress class >> byteToString: anInteger [
	^ anInteger printStringBase: 16 length: 2 padded: true
]

{ #category : #printing }
CwMACAddress class >> displaySeparator [
	^ $:
]

{ #category : #examples }
CwMACAddress class >> rawAddressToStringExample [
	<gtExample>
	self assert: (CwMACAddress rawAddressToString: 65280) equals: '00:00:00:00:FF:00'.
]

{ #category : #accessing }
CwMACAddress class >> sizeInBytes [
	^ 6
]

{ #category : #utilities }
CwMACAddress class >> stringToByte: aString [
	^ Integer readFrom: aString radix: 16
]

{ #category : #examples }
CwMACAddress class >> stringToRawAddressExample [
	<gtExample>
	self assert: (CwMACAddress stringToRawAddress: '00:00:00:00:FF:00') equals: 65280.
]
