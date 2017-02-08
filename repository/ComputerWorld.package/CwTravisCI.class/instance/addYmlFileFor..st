as yet unclassified
addYmlFileFor: repositoryFolder

	| reference contents |
	reference := repositoryFolder / '.travis.yml'.
	reference exists ifTrue: [ ^ reference ].
	contents := 'language: smalltalk
sudo: false

# Select operating system(s)
os:
  #- linux
  - osx

# Select compatible Smalltalk image(s)
smalltalk:
  - Pharo-6.0
  - Pharo-5.0' withUnixLineEndings.
	reference ensureCreateFile writeStreamDo: [ :s | s nextPutAll: contents ]
