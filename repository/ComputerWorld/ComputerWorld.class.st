"
ComputerWorld has not been documented yet. The class comment should describe the purpose of the class, its collaborations and its variables.

Instance Variables:
	software	<(Collection of: Object)>
	webHostingServices	<Collection>
	onlineFiles	<(Collection of: Object)>
	projects	<OrderedCollection> 
"
Class {
	#name : #ComputerWorld,
	#superclass : #Object,
	#instVars : [
		'software',
		'webHostingServices',
		'onlineFiles',
		'projects'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ComputerWorld-Core'
}

{ #category : #persistence }
ComputerWorld class >> restoreFrom: anObject [

	uniqueInstance := anObject.
]

{ #category : #persistence }
ComputerWorld class >> spData [

	^ uniqueInstance
]

{ #category : #'instance creation' }
ComputerWorld class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #'as yet unclassified' }
ComputerWorld >> addWebHostingService: aWebHostingService [

	webHostingServices add: aWebHostingService.
]

{ #category : #'as yet unclassified' }
ComputerWorld >> initialize [

	software := OrderedCollection new.
	webHostingServices := OrderedCollection new.
	onlineFiles := OrderedCollection new.
	projects := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
ComputerWorld >> onlineFileAt: aUrlOfString [

	^ onlineFiles
		detect: [ :f | f = (CwOnlineFile at: aUrlOfString asUrl) ]
		ifNone: [ onlineFiles add: (CwOnlineFile at: aUrlOfString asUrl) ].
]

{ #category : #'as yet unclassified' }
ComputerWorld >> software [

	^ software.
]

{ #category : #'as yet unclassified' }
ComputerWorld >> softwareNamed: aString [ 

	^ software
		detect: [ :s | s = (CwSoftware named: aString) ]
		ifNone: [ software add: (CwSoftware named: aString) ].
]
