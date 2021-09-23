Class {
	#name : 'CwAdobeCreativeCloud',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwAdobeCreativeCloud class >> install [
	('open ', 'https://creative.adobe.com/products/download/lightroom') asOssCommand run
]

{ #category : 'as yet unclassified' }
CwAdobeCreativeCloud class >> processNames [
	^ #('AGMService' 'Adobe Desktop Service')
]
