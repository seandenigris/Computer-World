as yet unclassified
saveTo: file

	file writeStreamDo: [ :str | lines do: [ :line | str nextPutAll: line ] separatedBy: [ str lf ] ].
