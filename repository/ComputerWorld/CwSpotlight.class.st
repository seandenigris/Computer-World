Class {
	#name : 'CwSpotlight',
	#superclass : 'CwLogitechApplication',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'accessing' }
CwSpotlight >> manual [
	^ self productHome / 'assets' / '65053' / 'spotlight-presentation-remote.pdf'
]
