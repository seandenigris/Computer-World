Class {
	#name : #CwLogitechApplication,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Apps'
}

{ #category : #testing }
CwLogitechApplication class >> isAbstract [
	^ true
]

{ #category : #accessing }
CwLogitechApplication >> productHome [
	^ 'https://logitech.com' asUrl
]

{ #category : #accessing }
CwLogitechApplication >> supportHome [
	^ 'https://support.logi.com' asUrl
]
