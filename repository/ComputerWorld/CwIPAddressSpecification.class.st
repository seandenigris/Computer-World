Class {
	#name : #CwIPAddressSpecification,
	#superclass : #BabyPhexample,
	#category : #'ComputerWorld-Specification'
}

{ #category : #tests }
CwIPAddressSpecification >> test [
	CwIPAddress examplePrivate displayString should equal: '172.16.0.0'
]

{ #category : #tests }
CwIPAddressSpecification >> testIsPrivate [
	CwIPAddress examplePrivate isPrivate should beTrue
]
