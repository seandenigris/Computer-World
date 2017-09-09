as yet unclassified
wikiImage: filename height: aNumber
	"From https://stackoverflow.com/a/26138535/424245"
	| mdTemplate |
	mdTemplate := '[[ images/{filename} | height = {height}px ]]'.
	^ mdTemplate format: { 
		#filename -> filename.
		#height -> aNumber asString } asDictionary