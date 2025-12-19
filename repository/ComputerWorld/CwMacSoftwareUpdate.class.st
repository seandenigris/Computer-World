Class {
	#name : 'CwMacSoftwareUpdate',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac',
	#package : 'ComputerWorld',
	#tag : 'Mac'
}

{ #category : 'as yet unclassified' }
CwMacSoftwareUpdate class >> processNames [
	"See https://apple.stackexchange.com/questions/170880/how-to-tell-what-program-is-launching-softwareupdated"
	^ #('softwareupdated' 'softwareupdate_download_service' 'softwareupdate_notify_agent')
]
