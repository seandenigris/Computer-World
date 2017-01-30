as yet unclassified
verifyKeyFingerprint: aString
	| soup keyTags keys |
	soup := Soup fromUrl: 'https://help.github.com/articles/github-s-ssh-key-fingerprints/' asUrl.
	keyTags := soup // #code.
	keys := keyTags collect: #text.
	(keys includes: aString)
		ifTrue: [ UIManager default inform: 'GitHub key validated!' ]
		ifFalse: [ self error: 'GitHub key doesn''t seem to be valid!' ]