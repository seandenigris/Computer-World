accessing
contents
	"Strip headers"
	| contentLines |
	contentLines := self file contents lines copyAfter: ''.
	^ String streamContents: [ :s |
			contentLines
				do: [ :l | s nextPutAll: l ]
				separatedBy: [ s lf ] ]