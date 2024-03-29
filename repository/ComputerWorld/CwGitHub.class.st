"
# Commit Messages
- Can contain links, but no markdown (as of 3/8/2022)
"
Class {
	#name : #CwGitHub,
	#superclass : #Object,
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwGitHub class >> rawUrlExample [
	<gtExample>
	
	^ self
		given: []
		when: [ self rawUrlFor: 'https://github.com/magritte-metamodel/magritte/blob/master/.project' asUrl ]
		then: [ :url | url should equal: 'https://raw.githubusercontent.com/magritte-metamodel/magritte/master/.project' asUrl ]
]

{ #category : #accessing }
CwGitHub class >> rawUrlFor: aUrl [

	^ aUrl copy
		host: 'raw.githubusercontent.com';
		clearPath;
		addPathSegments: (aUrl pathSegments copyWithoutIndex: 3);
		yourself
]

{ #category : #'as yet unclassified' }
CwGitHub class >> verifyKeyFingerprint: aString [
	| soup keyTags keys |
	soup := Soup fromUrl: 'https://help.github.com/articles/github-s-ssh-key-fingerprints/' asUrl.
	keyTags := soup // #code.
	keys := keyTags collect: #text.
	(keys includes: aString)
		ifTrue: [ UIManager default inform: 'GitHub key validated!' ]
		ifFalse: [ self error: 'GitHub key doesn''t seem to be valid!' ]
]

{ #category : #'as yet unclassified' }
CwGitHub class >> wikiAddImage [
	"From http://mikehadlow.blogspot.com/2014/03/how-to-add-images-to-github-wiki.html
	- Clone wiki
	- Add images folder
	- Link to an image e.g. `[[images/Signature XML in GT.jpeg]]`"
]

{ #category : #'as yet unclassified' }
CwGitHub class >> wikiImage: filename height: aNumber [
	"From https://stackoverflow.com/a/26138535/424245"
	| mdTemplate |
	mdTemplate := '[[ images/{filename} | height = {height}px ]]'.
	^ mdTemplate format: { 
		#filename -> filename.
		#height -> aNumber asString } asDictionary
]
