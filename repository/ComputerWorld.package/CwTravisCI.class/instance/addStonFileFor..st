as yet unclassified
addStonFileFor: repositoryFolder

	| contentsTemplate reference contents baselineName |
	reference := repositoryFolder / '.smalltalk.ston'.
	reference exists ifTrue: [ ^ reference ].
	
	baselineName := repositoryFolder base select: [ :c | c isAlphaNumeric ].
	contentsTemplate := 'SmalltalkCISpec \{
  #loading : [
    SCIMetacelloLoadSpec \{
      #baseline : ''{baselineName}'',
      #directory : ''repository'',
      #platforms : [ #pharo ]
    }
  ]
}' withUnixLineEndings.
	contents := contentsTemplate format: { #baselineName -> baselineName } asDictionary.
	reference ensureCreateFile writeStreamDo: [ :s | s nextPutAll: contents ]
