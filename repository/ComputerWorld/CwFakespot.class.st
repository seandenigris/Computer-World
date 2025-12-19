Class {
	#name : 'CwFakespot',
	#superclass : 'Object',
	#category : 'ComputerWorld-Core',
	#package : 'ComputerWorld',
	#tag : 'Core'
}

{ #category : 'instance creation' }
CwFakespot class >> openOn: aUrl [

	self new openOn: aUrl
]

{ #category : 'instance creation' }
CwFakespot >> openOn: aUrl [ 
	
	| url |
	url := 'https://www.fakespot.com/analyze' asUrl
		queryAt: 'url' put: aUrl
		yourself.
	CwSafari new openInNewWindow: url
]
