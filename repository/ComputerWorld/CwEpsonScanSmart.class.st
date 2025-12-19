Class {
	#name : 'CwEpsonScanSmart',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwEpsonScanSmart class >> debugMissingScanner [

	"The scanner monitor must be running, and must be run be the same user launching Scan Smart"
	self assert: CwEpsonScannerMonitor new isEffectiveUserProcess
]

{ #category : 'as yet unclassified' }
CwEpsonScanSmart class >> processNames [
	^ #('Epson Scanner Monitor')
]
