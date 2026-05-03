Class {
	#name : 'CwAdobePodcast',
	#superclass : 'CwSoftware',
	#category : 'ComputerWorld',
	#package : 'ComputerWorld'
}

{ #category : 'public' }
CwAdobePodcast >> speechEnhance: anRlResourceable [

	self speechEnhanceUrl open.
	anRlResourceable asRlResource showInFinder.
]

{ #category : 'public' }
CwAdobePodcast >> speechEnhanceIn: file [

	self speechEnhanceUrl open.
	file showInFinder.
]

{ #category : 'accessing' }
CwAdobePodcast >> speechEnhanceUrl [

	^ 'https://podcast.adobe.com/en/enhance' asUrl
]
