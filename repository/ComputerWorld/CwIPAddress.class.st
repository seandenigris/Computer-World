Class {
	#name : #CwIPAddress,
	#superclass : #CwInternetAddress,
	#category : #'ComputerWorld-Networking'
}

{ #category : #utilities }
CwIPAddress class >> byteToString: anInteger [
	^ anInteger printString
]

{ #category : #printing }
CwIPAddress class >> displaySeparator [
	^ $.
]

{ #category : #'instance creation' }
CwIPAddress class >> example [
	<gtExample>
	^ CwIPAddress fromString: '169.254.0.1'
]

{ #category : #examples }
CwIPAddress class >> exampleMasking [
	<gtExample>
	| result |
	result := self example maskedWith: CwIPSubnetMask example16.
	result should equalString: '169.254.0.0'.
	^ result
]

{ #category : #'instance creation' }
CwIPAddress class >> examplePrivate [
	<sampleInstance>
	^ CwIPAddress fromString: '172.16.0.0'
]

{ #category : #accessing }
CwIPAddress class >> maxRawAddress [
	^ 4294967295.	"#[ 255 255 255 255 ] asInteger."
]

{ #category : #examples }
CwIPAddress class >> rawAddressToStringExample [
	<gtExample>
	(CwIPAddress rawAddressToString: 2851995649) should equal: '169.254.0.1'.
]

{ #category : #accessing }
CwIPAddress class >> sizeInBytes [
	^ 4
]

{ #category : #utilities }
CwIPAddress class >> stringToByte: aString [
	^ aString asInteger
]

{ #category : #examples }
CwIPAddress class >> stringToRawAddressExample [
	<gtExample>
	(CwIPAddress stringToRawAddress: '169.254.0.1') should equal: 2851995649.
]

{ #category : #converting }
CwIPAddress >> asCwIPAddress [
	^ self
]

{ #category : #accessing }
CwIPAddress >> isOnSubnet: aSubnetMask with: anIPAddress [

	| mockNetwork |
	mockNetwork := CwIPAddressRange
		including: self
		subnetMask: aSubnetMask.
	^ mockNetwork includes: anIPAddress
]

{ #category : #testing }
CwIPAddress >> isPrivate [
	| privateRanges |
	privateRanges := { 
		CwIPAddressRange startingAt: '10.0.0.0' subnetMask: '255.0.0.0'.
		CwIPAddressRange startingAt: '172.0.0.0' subnetMask: '255.0.0.0'.
		CwIPAddressRange startingAt: '192.168.0.0' subnetMask: '255.255.0.0'.
	}.
	^ privateRanges anySatisfy: [ :e | e includes: self ]
]

{ #category : #accessing }
CwIPAddress >> maskedWith: anAddress [
	^ CwIPAddress fromInteger: (self rawAddress bitAnd: anAddress rawAddress)
]

{ #category : #accessing }
CwIPAddress >> open [
	^ Smalltalk tools webBrowser new open: ('https://', self displayString) asZnUrl.
]

{ #category : #accessing }
CwIPAddress >> should [
	^ CwIPAddressShouldSpec withReceiver: self asShouldExpressionReceiver
]

{ #category : #'magritte-accessing' }
CwIPAddress >> stringDescription [
	"<magritteDescription>"
	self flag: 'Part of experiment to describe types in multiple ways, one of which being a simple string equivalent. Doesn''t work if enabled at the same time as #rawAddressdescription, presumably because they both operate on the same data'.
	^ MAIPAddressDescription new
		label: 'IP Address';
		accessor: (MASelectorAccessor read: #displayString write: #copySameFrom:);
		yourself
]
