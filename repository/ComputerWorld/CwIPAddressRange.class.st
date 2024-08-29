Class {
	#name : #CwIPAddressRange,
	#superclass : #Object,
	#instVars : [
		'start',
		'subnetMask',
		'name'
	],
	#classVars : [
		'Networks'
	],
	#category : #'ComputerWorld-Networking'
}

{ #category : #examples }
CwIPAddressRange class >> exampleIncluding [
	<gtExample>
	^ self 
		given: [  ] 
		when: [ self including: CwIPAddress example subnetMask: CwIPSubnetMask example16 ]
		then: [ :net |
			(net includes: '169.254.0.0' asCwIPAddress) should be: true.
			(net includes: '169.254.255.255' asCwIPAddress) should be: true.
			(net includes: '169.255.0.0' asCwIPAddress) should be: false ].
]

{ #category : #examples }
CwIPAddressRange class >> examplePrivate10 [

	<gtExample>
	^ self given: [  ] when: [ self private10 ] then: [ :net | 
		  (net includes: '10.0.0.0' asCwIPAddress) should be: true.
		  (net includes: '10.255.255.255' asCwIPAddress) should be: true.
		  (net includes: '11.0.0.0' asCwIPAddress) should be: false ]
]

{ #category : #examples }
CwIPAddressRange class >> examplePrivate172 [

	<gtExample>
	^ self given: [  ] when: [ self private172 ] then: [ :net | 
		  (net includes: '172.16.0.0' asCwIPAddress) should be: true.
		  (net includes: '172.31.255.255' asCwIPAddress) should be: true.
		  (net includes: '172.32.0.0' asCwIPAddress) should be: false ]
]

{ #category : #examples }
CwIPAddressRange class >> examplePrivate192 [

	<gtExample>
	^ self given: [  ] when: [ self private192 ] then: [ :net | 
		  (net includes: '192.168.0.0' asCwIPAddress) should be: true.
		  (net includes: '192.168.255.255' asCwIPAddress) should be: true.
		  (net includes: '192.169.0.0' asCwIPAddress) should be: false ]
]

{ #category : #accessing }
CwIPAddressRange class >> including: address subnetMask: maskAddress [
	"CwIPAddressRange startingAt: CwIPAddress example subnetMask: CwIPAddress exampleMask"
	| startAddress |
	startAddress := address maskedWith: maskAddress.
	^ self new
			start: startAddress;
			subnetMask: maskAddress;
			yourself
]

{ #category : #accessing }
CwIPAddressRange class >> linkLocal [
	"If no DHCP server is found, then it is common practice for OSs to assign an IP address in this range (per https://www.ni.com/en-us/support/documentation/supplemental/11/best-practices-for-using-multiple-network-interfaces--nics--with.html)"
	^ self startingAt: '169.254.0.0' subnetMask: '255.255.0.0'
]

{ #category : #accessing }
CwIPAddressRange class >> networks [

	^ Networks ifNil: [ Networks := SortedCollection sortUsing: #name ascending ]
]

{ #category : #accessing }
CwIPAddressRange class >> networks: anObject [

	Networks := anObject
]

{ #category : #examples }
CwIPAddressRange class >> private10 [

	^ self
		  startingAt: '10.0.0.0' asCwIPAddress
		  subnetMask: (CwIPSubnetMask reservedBits: 8)
]

{ #category : #examples }
CwIPAddressRange class >> private172 [

	^ self
		  startingAt: '172.16.0.0' asCwIPAddress
		  subnetMask: (CwIPSubnetMask reservedBits: 12)
]

{ #category : #examples }
CwIPAddressRange class >> private192 [

	^ self
		  startingAt: '192.168.0.0' asCwIPAddress
		  subnetMask: (CwIPSubnetMask reservedBits: 16)
]

{ #category : #accessing }
CwIPAddressRange class >> restoreFrom: aCollection [

	self networks: aCollection.
]

{ #category : #accessing }
CwIPAddressRange class >> spData [

	^ self networks
]

{ #category : #accessing }
CwIPAddressRange class >> startingAt: address subnetMask: maskAddress [

	^ self new
			start: address asCwIPAddress;
			subnetMask: maskAddress asCwIPSubnetMask;
			yourself
]

{ #category : #comparing }
CwIPAddressRange >> = rhs [
	^ self start = rhs start and: [ self subnetMask = rhs subnetMask ]
]

{ #category : #accessing }
CwIPAddressRange >> availableAddresses [
	^ self subnetMask rawAddress bitInvert32 + 1
]

{ #category : #'magritte-accessing' }
CwIPAddressRange >> availableAddressesDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #availableAddresses;
		readOnly: true;
		yourself
]

{ #category : #comparing }
CwIPAddressRange >> hash [
	^ self start hash bitXor: self subnetMask hash
]

{ #category : #testing }
CwIPAddressRange >> includes: address [
	"Reference: https://www.ni.com/en-us/support/documentation/supplemental/11/best-practices-for-using-multiple-network-interfaces--nics--with.html"
	| differentBits differentNetworkBits |
	differentBits := self start rawAddress bitXor: address rawAddress.
	differentNetworkBits := differentBits bitAnd: subnetMask rawAddress.
	^ differentNetworkBits = 0
]

{ #category : #accessing }
CwIPAddressRange >> name [

	^ name
]

{ #category : #accessing }
CwIPAddressRange >> name: anObject [

	name := anObject
]

{ #category : #accessing }
CwIPAddressRange >> printOn: aStream [
	self name ifNotNil: [ :n |
		aStream nextPutAll: n; space ].
		
	aStream 
		print: self start;
		nextPutAll: self subnetMask slashNotation.
]

{ #category : #accessing }
CwIPAddressRange >> start [
	^ start
]

{ #category : #accessing }
CwIPAddressRange >> start: anObject [
	start := anObject
]

{ #category : #accessing }
CwIPAddressRange >> subnetMask [
	^ subnetMask
]

{ #category : #accessing }
CwIPAddressRange >> subnetMask: anObject [
	subnetMask := anObject
]
