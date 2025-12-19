Class {
	#name : 'CwAdobeCreativeCloud',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwAdobeCreativeCloud class >> install [
	('open ', 'https://creative.adobe.com/products/download/lightroom') asOssCommand run
]

{ #category : 'accessing' }
CwAdobeCreativeCloud class >> processNames [
	"Here is a list describing the background processes/helperss: https://helpx.adobe.com/x-productkb/global/adobe-background-processes.html"
	^ #('AGMService' 'Adobe Desktop Service')
]
