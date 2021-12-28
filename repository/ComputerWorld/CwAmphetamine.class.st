Class {
	#name : #CwAmphetamine,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwAmphetamine class >> bundleBasename [
	^ 'Amphetamine.app'
]

{ #category : #'as yet unclassified' }
CwAmphetamine >> endSession [
	self tellApplicationTo: 'end session'.
]

{ #category : #'as yet unclassified' }
CwAmphetamine >> startIndefiniteSession [
	self tellApplicationTo: 'start new session with options {duration:0, interval:0, displaySleepAllowed:true}'.
]

{ #category : #'as yet unclassified' }
CwAmphetamine >> stayAwakeDuring: aBlock [

	self startIndefiniteSession.
	aBlock value.
	self endSession
]
