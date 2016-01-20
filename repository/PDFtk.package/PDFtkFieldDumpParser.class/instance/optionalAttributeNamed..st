as yet unclassified
optionalAttributeNamed: aString 

	^ (self attributeNamed: aString) optional  ==> [ :node | node ifNil: [ '' ] ].