accessing
binary

	^ Smalltalk os isWin32
		ifTrue: [ FileLocator imageDirectory / 'lib' / 'pdftk.exe' ]
		ifFalse:[ '/usr/local/bin/pdftk' asFileReference ].