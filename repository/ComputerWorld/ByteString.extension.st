Extension { #name : 'ByteString' }

{ #category : '*ComputerWorld' }
ByteString >> asCwIPAddress [
	^ CwIPAddress fromString: self
]

{ #category : '*ComputerWorld' }
ByteString >> asCwIPSubnetMask [
	^ CwIPSubnetMask fromString: self
]

{ #category : '*ComputerWorld' }
ByteString >> homebrewName [
	^ self
]
