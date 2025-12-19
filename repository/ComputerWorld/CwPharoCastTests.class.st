Class {
	#name : 'CwPharoCastTests',
	#superclass : 'TestCase',
	#category : 'ComputerWorld-Specification',
	#package : 'ComputerWorld',
	#tag : 'Specification'
}

{ #category : 'accessing' }
CwPharoCastTests >> testCreation [

	| pharoCast |
	pharoCast := CwPharoCast titled: 'Pharo GUI with Polymorph'.
	pharoCast title should equal: 'Pharo GUI with Polymorph'.
]
