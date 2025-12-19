Class {
	#name : 'CwPipfileParser',
	#superclass : 'PeTomlParseNodeVisitor',
	#instVars : [
		'sources',
		'currentDictionary',
		'object'
	],
	#category : 'ComputerWorld-Python',
	#package : 'ComputerWorld',
	#tag : 'Python'
}

{ #category : 'accessing' }
CwPipfileParser class >> parseFile: file [
	| parseTree |
	parseTree := PeTOMLParser parse: file contents.
	^ self new
		accept: parseTree;
		object.
]

{ #category : 'accessing' }
CwPipfileParser class >> parseFile: file to: aPePipFile [
	| parseTree |
	parseTree := PeTOMLParser parse: file contents.
	self new
		object: aPePipFile;
		accept: parseTree.
]

{ #category : 'accessing' }
CwPipfileParser >> currentDictionary [
	^ currentDictionary
]

{ #category : 'accessing' }
CwPipfileParser >> object [
	^ object ifNil: [ object := CwPipfile new ]
]

{ #category : 'accessing' }
CwPipfileParser >> object: aPePipfile [
	object := aPePipfile
]

{ #category : 'accessing' }
CwPipfileParser >> sources [
	^ sources ifNil: [ OrderedCollection new ]
]

{ #category : 'accessing' }
CwPipfileParser >> visitArrayTable: anArrayTable [
	anArrayTable key = 'source' ifFalse: [ self error: 'source is the only known valid array table' ].
	
	currentDictionary := Dictionary new.
	self object sources add: currentDictionary.
]

{ #category : 'accessing' }
CwPipfileParser >> visitKeyValue: aKeyValue [

	self currentDictionary at: aKeyValue key put: aKeyValue value
]

{ #category : 'accessing' }
CwPipfileParser >> visitStandardTable: aStandardTable [
	| knownTables selector |
	knownTables := #('dev-packages' 'packages' 'requires').
	(knownTables includes: aStandardTable key) ifFalse: [ self error: 'unkown table ', aStandardTable key ].
	
	selector := (aStandardTable key copyReplaceAll: '-' with: ' ') asCamelCase uncapitalized asSymbol.
	currentDictionary := self object perform: selector.
]
