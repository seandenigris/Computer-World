Class {
	#name : 'CwLGHub',
	#superclass : 'CwLogitechApplication',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'accessing' }
CwLGHub class >> bundle [
	^ '/Applications/lghub.app' asFileReference
]

{ #category : 'accessing' }
CwLGHub >> manual [
	^ self productHome / 'assets' / '65550' / 'ghub.pdf'
]

{ #category : 'accessing' }
CwLGHub >> productHome [
	^ 'https://logitech.com' asUrl
]

{ #category : 'accessing' }
CwLGHub >> supportHome [
	^ 'https://support.logi.com' asUrl
]
