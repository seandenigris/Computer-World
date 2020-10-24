Class {
	#name : #CwLepiter,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwLepiter class >> bundle [
	^ '/Applications/Lepiter.app' asFileReference
]
