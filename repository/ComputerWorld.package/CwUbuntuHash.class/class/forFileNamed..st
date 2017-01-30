accessing
forFileNamed: basename

	^ self all 
		detect: [ :e | e filename = basename ]
		ifNone: [ self error: 'Ubuntu does not list a hash for ', basename, ' at ', self secureUrl asString ].