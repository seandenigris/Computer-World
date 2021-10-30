Class {
	#name : #CwIPAddressShouldSpec,
	#superclass : #SpecOfShouldExpression,
	#category : #ComputerWorld
}

{ #category : #accessing }
CwIPAddressShouldSpec >> equal: anObject [
	^ super equal: anObject asCwIPAddress
]

{ #category : #accessing }
CwIPAddressShouldSpec >> equalInteger: anInteger [
	^ super equal: (self receiver value class fromInteger: anInteger)
]

{ #category : #accessing }
CwIPAddressShouldSpec >> equalString: aString [
	^ super equal: (self receiver value class fromString: aString)
]
