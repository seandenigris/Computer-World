as yet unclassified
softwareNamed: aString 

	^ software
		detect: [ :s | s = (Software named: aString) ]
		ifNone: [ software add: (Software named: aString) ].