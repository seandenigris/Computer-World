Class {
	#name : #CwNetworkAdapter,
	#superclass : #Object,
	#instVars : [
		'ipAddress',
		'description',
		'usage',
		'speed',
		'macAddress'
	],
	#category : 'ComputerWorld-NAS'
}

{ #category : #accessing }
CwNetworkAdapter >> description [
	^ self maLazyInstVarUsing: self descriptionDescription
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
	^ self maLazyInstVarUsing: self ipAddressDescription
]

{ #category : #accessing }
CwNetworkAdapter >> ipAddress: aString [
	ipAddress := aString
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> ipAddressDescription [
	<magritteDescription>
	^ MAIPAddressDescription new
		accessor: #ipAddress;
		yourself
]

{ #category : #accessing }
CwNetworkAdapter >> isSameNetworkAs: aCwIPAddress [ 
	self error: 'Incomplete implementation: need to find *all* our ipAddresses and both subnet masks'.
	self ipAddress ifNil: [ ^ false ].
	aCwIPAddress ifNil: [ ^ false ].
	^ (self ipAddress asByteArray first: 2) = (aCwIPAddress asByteArray first: 2)
]

{ #category : #accessing }
CwNetworkAdapter >> macAddress [
	^ self maLazyInstVarUsing: self macAddressDescription
]

{ #category : #accessing }
CwNetworkAdapter >> macAddress: aString [
	macAddress := aString
]

{ #category : #'magritte-accessing' }
CwNetworkAdapter >> macAddressDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #macAddress;
		yourself
]

{ #category : #printing }
CwNetworkAdapter >> printOn: aStream [
	aStream
		nextPutAll: self description;
		nextPutAll: ' ('.
	self speed ifNotNil: [ :spd |
		aStream 
			print: spd;
			nextPutAll: 'Gb/s';
			nextPutAll: ' - ' ].
	self ipAddress ifNotNil: [ :ip |
		aStream print: ip ].
	aStream nextPut: $)
	
]

{ #category : #accessing }
CwNetworkAdapter >> speed [
	^ self maLazyInstVarUsing: self speedDescription
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
	^ self maLazyInstVarUsing: self usageDescription
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

{ #category : #accessing }
CwNetworkAdapter >> wakeOnLAN [
	| packet socket |
	"Adapted from description at https://www.tweaking4all.com/network-internet/miniwol-wake-on-lan/"
	packet := ByteArray streamContents: [ :str |
		6 timesRepeat: [ str nextPut: (Integer readFrom: 'FF' radix: 16) ].
		16 timesRepeat: [ str nextPutAll: self macAddress asByteArray ] ].
	socket := Socket newUDP.
	[ 
		| bytesSent |
		bytesSent := socket sendData: packet toHost: self ipAddress asByteArray port: 7.
		self assert: bytesSent equals: packet size ] ensure: [ socket closeAndDestroy ].
]
