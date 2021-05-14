Class {
	#name : #'CwIP_Address',
	#superclass : #CwInternetAddress,
	#category : #'ComputerWorld-Core'
}

{ #category : #utilities }
CwIP_Address class >> byteToString: anInteger [
	^ anInteger printString
]

{ #category : #printing }
CwIP_Address class >> displaySeparator [
	^ $.
]

{ #category : #'instance creation' }
CwIP_Address class >> example [
	<gtExample>
	^ CwIP_Address fromString: '169.254.0.1'
]

{ #category : #'instance creation' }
CwIP_Address class >> exampleMask [
	<sampleInstance>
	^ CwIP_Address fromString: '255.255.0.0'
]

{ #category : #example }
CwIP_Address class >> exampleMasking [
	<gtExample>
	| result |
	result := self example maskedWith: self exampleMask.
	self assert: result equals: (CwIP_Address fromString: '169.254.0.0').
	^ result
]

{ #category : #'instance creation' }
CwIP_Address class >> examplePrivate [
	<sampleInstance>
	^ CwIP_Address fromString: '172.16.0.0'
]

{ #category : #accessing }
CwIP_Address class >> maxRawAddress [
	^ 4294967295.	"#[ 255 255 255 255] asInteger."
]

{ #category : #examples }
CwIP_Address class >> rawAddressToStringExample [
	<gtExample>
	self assert: (CwIP_Address rawAddressToString: 2851995649) equals: '169.254.0.1'.
]

{ #category : #'as yet unclassified' }
CwIP_Address class >> sizeInBytes [
	^ 4
]

{ #category : #utilities }
CwIP_Address class >> stringToByte: aString [
	^ aString asInteger
]

{ #category : #examples }
CwIP_Address class >> stringToRawAddressExample [
	<gtExample>
	self assert: (CwIP_Address stringToRawAddress: '169.254.0.1') equals: 2851995649.
]

{ #category : #converting }
CwIP_Address >> asCwIPAddress [
	^ self
]

{ #category : #testing }
CwIP_Address >> isPrivate [
	| privateRanges |
	privateRanges := { 
		CwIPAddressRange startingAt: '10.0.0.0' subnetMask: '255.0.0.0'.
		CwIPAddressRange startingAt: '172.0.0.0' subnetMask: '255.0.0.0'.
		CwIPAddressRange startingAt: '192.168.0.0' subnetMask: '255.255.0.0'.
	}.
	^ privateRanges anySatisfy: [ :e | e includes: self ]
]

{ #category : #accessing }
CwIP_Address >> maskedWith: anAddress [
	^ CwIP_Address fromInteger: (self rawAddress bitAnd: anAddress rawAddress)
]

{ #category : #accessing }
CwIP_Address >> open [
	^ Smalltalk tools webBrowser new open: ('https://', self displayString) asZnUrl.
]

{ #category : #'magritte-accessing' }
CwIP_Address >> stringDescription [
	"<magritteDescription>"
	self flag: 'Part of experiment to describe types in multiple ways, one of which being a simple string equivalent. Doesn''t work if enabled at the same time as #rawAddressdescription, presumably because they both operate on the same datat'.
	^ MAIPAddressDescription new
		label: 'IP Address';
		accessor: (MASelectorAccessor read: #displayString write: #copySameFrom:);
		yourself
]
