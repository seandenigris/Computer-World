Class {
	#name : #CwLogitechApplication,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Apps'
}

{ #category : #accessing }
CwLogitechApplication >> productHome [
	^ 'https://logitech.com' asUrl
]

{ #category : #accessing }
CwLogitechApplication >> supportHome [
	^ 'https://support.logi.com' asUrl
]
