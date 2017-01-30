as yet unclassified
softwareNamed: aString 

	^ software
		detect: [ :s | s = (CwSoftware named: aString) ]
		ifNone: [ software add: (CwSoftware named: aString) ].