"
[Here](https://superuser.com/questions/1191136/why-are-subnet-masks-relevant-for-the-individual-computer-on-the-network) and [here](https://www.ni.com/en-us/support/documentation/supplemental/11/best-practices-for-using-multiple-network-interfaces--nics--with.html) are two great resources explaining what subnet masks are and why every ethernet adapter needs to know its subnet.
"
Class {
	#name : 'CwIPSubnetMask',
	#superclass : 'CwIPAddress',
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'accessing' }
CwIPSubnetMask class >> example16 [
	<gtExample>
	^ self
		given: []
		when: [ self reservedBits: 16 ]
		then: [ :result | result should equalString: '255.255.0.0' ]	
]

{ #category : 'accessing' }
CwIPSubnetMask class >> example8 [
	<gtExample>
	^ self
		given: []
		when: [ self reservedBits: 8 ]
		then: [ :result | result should equalString: '255.0.0.0' ]	
]

{ #category : 'accessing' }
CwIPSubnetMask class >> reservedBits: anInteger [
	| integerValue |
	integerValue := 0.
	1 to: anInteger do: [ :i |
		integerValue := integerValue bitAt: 33 - i put: 1 ].
	^ self fromInteger: integerValue
]

{ #category : 'as yet unclassified' }
CwIPSubnetMask >> asCwIPSubnetMask [

	^ self
]

{ #category : 'accessing' }
CwIPSubnetMask >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: self slashNotation
]

{ #category : 'accessing' }
CwIPSubnetMask >> reservedBits [
	^ 33 - self rawAddress lowBit
]

{ #category : 'accessing' }
CwIPSubnetMask >> slashNotation [
	^ '/', self reservedBits asString
]
