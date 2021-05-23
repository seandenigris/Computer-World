Class {
	#name : #CwIPAddressShouldSpec,
	#superclass : #SpecOfShouldExpression,
	#category : #ComputerWorld
}

{ #category : #accessing }
CwIPAddressShouldSpec >> equal: anObject [
	^ super equal: anObject asCwIPAddress
]
