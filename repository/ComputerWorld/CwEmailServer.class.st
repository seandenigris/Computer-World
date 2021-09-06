Class {
	#name : 'CwEmailServer',
	#superclass : 'CwServer',
	#instVars : [
		'forwarders'
	],
	#category : 'ComputerWorld-NAS'
}

{ #category : 'accessing' }
CwEmailServer >> forwarders [
	^ forwarders ifNil: [ forwarders := OrderedCollection new ]
]
