Class {
	#name : #'CwMAC_Address',
	#superclass : #CwInternetAddress,
	#category : #'ComputerWorld-Core'
}

{ #category : #utilities }
CwMAC_Address class >> byteToString: anInteger [
	^ anInteger printStringBase: 16 length: 2 padded: true
]

{ #category : #printing }
CwMAC_Address class >> displaySeparator [
	^ $:
]

{ #category : #examples }
CwMAC_Address class >> rawAddressToStringExample [
	<gtExample>
	self assert: (CwMAC_Address rawAddressToString: 65280) equals: '00:00:00:00:FF:00'.
]

{ #category : #accessing }
CwMAC_Address class >> sizeInBytes [
	^ 6
]

{ #category : #utilities }
CwMAC_Address class >> stringToByte: aString [
	^ Integer readFrom: aString radix: 16
]

{ #category : #examples }
CwMAC_Address class >> stringToRawAddressExample [
	<gtExample>
	self assert: (CwMAC_Address stringToRawAddress: '00:00:00:00:FF:00') equals: 65280.
]
