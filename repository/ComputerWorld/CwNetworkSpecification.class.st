Class {
	#name : #CwNetworkSpecification,
	#superclass : #TestCase,
	#category : #'ComputerWorld-Specification'
}

{ #category : #tests }
CwNetworkSpecification >> testAvailableAddresses [
	
	| net subnetMasks |
	subnetMasks := {
		'255.255.255.254' -> (2 raisedTo: 1).
		'255.255.255.0' -> (2 raisedTo: 8).
		'255.255.0.0' -> (2 raisedTo: 16).
	}.
	net := CwIPAddressRange startingAt: '192.168.0.0' subnetMask: '255.255.255.255'.
	subnetMasks do: [ :e | 
		net subnetMask: e key asCwIPAddress.
		net availableAddresses should equal: e value ]
]

{ #category : #tests }
CwNetworkSpecification >> testConvertToString [
	CwIPAddress examplePrivate displayString should equal: '172.16.0.0'
]

{ #category : #tests }
CwNetworkSpecification >> testCreating [
	| n1 n2 |
	n1 := CwIPAddressRange startingAt: '192.168.0.0' subnetMask: '255.255.0.0'.
	n2 := CwIPAddressRange startingAt: '192.168.0.0' subnetMask: 16.
	n1 should equal: n2
]

{ #category : #tests }
CwNetworkSpecification >> testIsPrivate [
	| privateAddresses nonPrivateAddresses |
	privateAddresses := #( 
		'10.0.0.0'
		'10.255.255.255'
		'172.0.0.0'
		'172.255.255.255'
		'192.168.0.0' 
		'192.168.255.255'
	).
	privateAddresses do: [ :e | (CwIPAddress fromString: e) should be isPrivate ].
	
	nonPrivateAddresses := #( 
		'9.255.255.255'
		'11.0.0.0'
		'171.255.255.255'
		'173.0.0.0'
		'192.167.255.255'
		'192.169.0.0' 
	).
	nonPrivateAddresses do: [ :e | (CwIPAddress fromString: e) should not be isPrivate ]
]
