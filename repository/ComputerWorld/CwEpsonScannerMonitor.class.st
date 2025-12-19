"
This utility must be running in order for Epson software to find scanners - for example if connected via USB.
"
Class {
	#name : 'CwEpsonScannerMonitor',
	#superclass : 'CwMacApplication',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwEpsonScannerMonitor class >> bundleBasename [

	^ 'Epson Scanner Monitor.app'
]

{ #category : 'as yet unclassified' }
CwEpsonScannerMonitor class >> bundleParent [

	^ '/Library/Application Support/EPSON/Scanner/ScannerMonitor' asFileReference
]

{ #category : 'as yet unclassified' }
CwEpsonScannerMonitor >> isEffectiveUserProcess [
	| output |
	output := SuGenericUnixCommand new
			template: 'ps x -o user,comm | grep {binary}';
			argumentAt: #binary put: self bundle;
			output.

	^ output lines
		anySatisfy: [ :line | 
			| user command |
			user := line copyUpTo: Character space.
			command := line copyAfter: Character space.
			user = CwMac current effectiveUser
				and: [ command beginsWith: self bundle fullName ] ]
]
