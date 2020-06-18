Class {
	#name : #PaPodcast,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#classVars : [
		'DB'
	],
	#category : #'Podcasts-Alive'
}

{ #category : #'as yet unclassified' }
PaPodcast class >> db [
	^ DB ifNil: [ DB := Bag new ]
]

{ #category : #'as yet unclassified' }
PaPodcast class >> exampleCreate [
	<sampleInstance>
	^ PaPodcast new
		url: 'https://feed.podbean.com/iaffpodcast/feed.xml' asUrl;
		yourself
]

{ #category : #'magritte-accessing' }
PaPodcast >> open [
	LibC system: 'open -a VLC ', (self url asString surroundedBy: '"')
]

{ #category : #accessing }
PaPodcast >> url [
	^ self maLazyFrom: self urlDescription
]

{ #category : #accessing }
PaPodcast >> url: anObject [
	url := anObject
]

{ #category : #'magritte-accessing' }
PaPodcast >> urlDescription [
	<magritteDescription>
	^ MAUrlDescription new
		accessor: #url;
		yourself
]
