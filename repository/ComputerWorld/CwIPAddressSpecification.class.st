Class {
	#name : #CwIPAddressSpecification,
	#superclass : #BabyPhexample,
	#category : #'ComputerWorld-Specification'
}

{ #category : #tests }
CwIPAddressSpecification >> test [
	CwIP_Address examplePrivate displayString should equal: '172.16.0.0'
]

{ #category : #tests }
CwIPAddressSpecification >> testIsPrivate [
	CwIP_Address examplePrivate isPrivate should beTrue
]
