Extension { #name : 'MAStringReader' }

{ #category : '*ComputerWorld' }
MAStringReader >> visitIPAddressDescription: aDescription [ 
	| contents |
	contents := self contents.
	(contents matchesRegex: '\d+\.\d+\.\d+.\d+') ifFalse: [ MAReadError signal ].
	self object: (aDescription kind fromString: contents).
]
