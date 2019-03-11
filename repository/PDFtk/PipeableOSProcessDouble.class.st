Class {
	#name : #PipeableOSProcessDouble,
	#superclass : #Object,
	#instVars : [
		'output'
	],
	#classInstVars : [
		'answers'
	],
	#category : 'PDFtk-Specification'
}

{ #category : #'as yet unclassified' }
PipeableOSProcessDouble class >> answers [

	^ answers ifNil: [ answers := Dictionary new ].
]

{ #category : #'as yet unclassified' }
PipeableOSProcessDouble class >> onCommand: commandString answer: anObject [ 

	self answers at: commandString put: anObject.
]

{ #category : #'as yet unclassified' }
PipeableOSProcessDouble class >> reset [

	answers removeAll.
]

{ #category : #'as yet unclassified' }
PipeableOSProcessDouble class >> waitForCommand: aString [

	| output |
	output := self answers at: aString trimRight ifAbsent: [ self error: 'POSP received: ', aString ].
	^ self new
		output: output;
		yourself.
]

{ #category : #accessing }
PipeableOSProcessDouble >> output [

	^ output
]

{ #category : #private }
PipeableOSProcessDouble >> output: aString [

	output := aString.
]
