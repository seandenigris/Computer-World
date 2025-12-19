Class {
	#name : 'MAIPAddressDescription',
	#superclass : 'MAElementDescription',
	#category : 'ComputerWorld-Magritte',
	#package : 'ComputerWorld',
	#tag : 'Magritte'
}

{ #category : 'accessing-defaults' }
MAIPAddressDescription class >> defaultKind [
	^ CwIPAddress
]

{ #category : 'visiting' }
MAIPAddressDescription >> acceptMagritte: aVisitor [
	aVisitor visitIPAddressDescription: self
]

{ #category : 'visiting' }
MAIPAddressDescription >> initialize [
	super initialize.
	self addCondition: [ :e | e rawAddress <= self kind maxRawAddress ].
]

{ #category : 'validation-private' }
MAIPAddressDescription >> validateSpecific: anObject [
	anObject rawAddress <= self kind maxRawAddress ifFalse: [ MAError signal ]
]
