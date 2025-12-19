Class {
	#name : 'CwIPAddressSpecification',
	#superclass : 'TestCase',
	#category : 'ComputerWorld-Specification',
	#package : 'ComputerWorld',
	#tag : 'Specification'
}

{ #category : 'tests' }
CwIPAddressSpecification >> test [
	CwIPAddress examplePrivate displayString should equal: '172.16.0.0'
]

{ #category : 'tests' }
CwIPAddressSpecification >> testIsPrivate [
	CwIPAddress examplePrivate should be isPrivate
]
