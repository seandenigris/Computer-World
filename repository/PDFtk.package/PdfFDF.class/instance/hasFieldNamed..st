private
hasFieldNamed: aString 

	^ lines anySatisfy: [ :e | '/T (', aString, ')' = e ].