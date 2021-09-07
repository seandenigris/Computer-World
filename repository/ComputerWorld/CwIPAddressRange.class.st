Class {
	#name : #CwIPAddressRange,
	#superclass : #Object,
	#instVars : [
		'start',
		'subnetMask',
		'availableAddresses'
	],
	#category : 'ComputerWorld-Core'
}

{ #category : #accessing }
CwIPAddressRange class >> including: address subnetMask: maskAddress [
	"CwIPAddressRange startingAt: CwIPAddress example subnetMask: CwIPAddress exampleMask"
	| startAddress |
	startAddress := address maskedWith: maskAddress.
	^ self new
			start: startAddress;
			subnetMask: maskAddress asCwIPAddress;
			yourself
]

{ #category : #accessing }
CwIPAddressRange class >> linkLocal [
	"If no DHCP server is found, then it is common practice for OSs to assign an IP address in this range (per https://www.ni.com/en-us/support/documentation/supplemental/11/best-practices-for-using-multiple-network-interfaces--nics--with.html)"
	^ self startingAt: '169.254.0.0' subnetMask: '255.255.0.0'
]

{ #category : #accessing }
CwIPAddressRange class >> startingAt: address subnetMask: maskAddress [
	"CwIPAddressRange startingAt: CwIPAddress example subnetMask: CwIPAddress exampleMask"
	^ self new
			start: address asCwIPAddress;
			subnetMask: maskAddress asCwIPAddress;
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
