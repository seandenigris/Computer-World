Class {
	#name : 'CwPasswordSpecification',
	#superclass : 'TestCase',
	#category : 'ComputerWorld-Specification',
	#package : 'ComputerWorld',
	#tag : 'Specification'
}

{ #category : 'tests' }
CwPasswordSpecification >> testEntropy [
	| pwd |
	pwd := CwPassword new
		possibilities: Character alphabet;
		length: 10;
		yourself.
	pwd entropy bits should equal: 47
]
