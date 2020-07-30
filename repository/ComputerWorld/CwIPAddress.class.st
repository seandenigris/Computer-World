Class {
	#name : #CwIPAddress,
	#superclass : #Object,
	#instVars : [
		'rawAddress'
	],
	#category : #'ComputerWorld-Core'
}

{ #category : #'instance creation' }
CwIPAddress class >> example [
	<sampleInstance>
	^ CwIPAddress fromString: '169.254.0.1'
]

{ #category : #'instance creation' }
CwIPAddress class >> exampleMask [
	<sampleInstance>
	^ CwIPAddress fromString: '255.255.0.0'
]

{ #category : #'instance creation' }
CwIPAddress class >> examplePrivate [
	<sampleInstance>
	^ CwIPAddress fromString: '172.16.0.0'
]

{ #category : #'instance creation' }
CwIPAddress class >> fromInteger: anInteger [
	"Example: 
		CwIPAddress fromInteger: 4294901760
	"

	^ self new
			rawAddress: anInteger;
			yourself
]

{ #category : #'instance creation' }
CwIPAddress class >> fromString: aString [
	"Example: 
		CwIPAddress fromString: '169.254.0.1'
	"
	
	^ self fromInteger: (self stringToRawAddress: aString)
]

{ #category : #'instance creation' }
CwIPAddress class >> maxRawAddress [
	^ 4294967295.	"#[ 255 255 255 255] asInteger."
]

{ #category : #'instance creation' }
CwIPAddress class >> rawAddressToString: anInteger [
	"Example: 
		(CwIPAddress rawAddressToString: 2851995649) >>> '169.254.0.1'
	"

	^ String streamContents: [ :s |
			(anInteger asByteArrayOfSize: 4) 
				do: [ :byte | s print: byte ]
				separatedBy: [ s nextPut: $. ] ]
]

{ #category : #'instance creation' }
CwIPAddress class >> stringToRawAddress: aString [
	"Example: 
		CwIPAddress stringToRawAddress: '169.254.0.1' >>> 2851995649
	"

	| byteStrings bytes |
	byteStrings := aString splitOn: $..
	bytes := byteStrings collect: [ :e | e asInteger ].
	^ (ByteArray newFrom: bytes) asInteger
]

{ #category : #comparing }
CwIPAddress >> = rhs [
	^ self species = rhs species and: [ self rawAddress = rhs rawAddress ]
]

{ #category : #comparing }
CwIPAddress >> hash [
	^ self rawAddress hash
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

{ #category : #printing }
CwIPAddress >> printOn: aStream [
	self rawAddress asByteArray 
		do: [ :byte | aStream print: byte ]
		separatedBy: [ aStream nextPut: $. ]
]

{ #category : #accessing }
CwIPAddress >> rawAddress [
	^ self maLazyFrom: self rawAddressDescription
]

{ #category : #accessing }
CwIPAddress >> rawAddress: aNumber [
	rawAddress := aNumber
]

{ #category : #'magritte-accessing' }
CwIPAddress >> rawAddressDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #rawAddress;
		default: 0;
		yourself
]

{ #category : #'magritte-accessing' }
CwIPAddress >> stringDescription [
	"<magritteDescription>"
	self flag: 'Part of experiment to describe types in multiple ways, one of which being a simple string equivalent. Doesn''t work if enabled at the same time as #rawAddressdescription, presumably because they both operate on the same datat'.
	^ MAIPAddressDescription new
		label: 'IP Address';
		accessor: (MASelectorAccessor read: #displayString write: #copySameFrom:);
		yourself
]
