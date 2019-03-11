Class {
	#name : #CwPharoCastTests,
	#superclass : #TestCase,
	#category : 'ComputerWorld-Specification'
}

{ #category : #'as yet unclassified' }
CwPharoCastTests >> testCreation [

	| pharoCast |
	pharoCast := CwPharoCast titled: 'Pharo GUI with Polymorph'.
	pharoCast title should = 'Pharo GUI with Polymorph'.
]
