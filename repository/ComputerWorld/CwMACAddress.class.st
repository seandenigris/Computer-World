Class {
	#name : 'CwMACAddress',
	#superclass : 'CwInternetAddress',
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'utilities' }
CwMACAddress class >> byteToString: anInteger [
	^ anInteger printStringBase: 16 length: 2 padded: true
]

{ #category : 'printing' }
CwMACAddress class >> displaySeparator [
	"Can be a colon, hypen, or absent [per Wikipedia](https://en.wikipedia.org/wiki/MAC_address)"
	^ $:
]

{ #category : 'examples' }
CwMACAddress class >> example [
	<gtExample>
	
	^ self fromString: '12:34:56:78:9A:BC'
]

{ #category : 'examples' }
CwMACAddress class >> rawAddressToStringExample [
	<gtExample>
	self assert: (CwMACAddress rawAddressToString: #[0 0 0 0 255 0] asInteger) equals: '00:00:00:00:FF:00'.
]

{ #category : 'accessing' }
CwMACAddress class >> sizeInBytes [
	^ 6
]

{ #category : 'utilities' }
CwMACAddress class >> stringToByte: aString [
	^ Integer readFrom: aString radix: 16
]

{ #category : 'accessing' }
CwMACAddress class >> stringToRawAddress: aString [

	^ Integer readFrom: (aString select: #isAlphaNumeric) base: 16
]

{ #category : 'examples' }
CwMACAddress class >> stringToRawAddressExample [
	<gtExample>
	self assert: (CwMACAddress stringToRawAddress: '00:00:00:00:FF:00') equals: #[0 0 0 0 255 0] asInteger.
]

{ #category : 'accessing' }
CwMACAddress >> gtMACViewFor: aView [
	<gtView>
	^ aView list 
		title: 'MAC';
		items: [ 
			{
				self printString.
				String streamContents: [ : s | self printOn: s separatedBy: $- ].
				self printString select: #isAlphaNumeric.
			} ]
]
