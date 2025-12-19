Class {
	#name : 'CwPharoCast',
	#superclass : 'Object',
	#instVars : [
		'title',
		'url'
	],
	#classInstVars : [
		'database'
	],
	#category : 'ComputerWorld-Core',
	#package : 'ComputerWorld',
	#tag : 'Core'
}

{ #category : 'accessing' }
CwPharoCast class >> database [

	^ database ifNil: [ database := OrderedCollection new ].
]

{ #category : 'world menu' }
CwPharoCast class >> menuCommandOn: aBuilder [ 

	<worldMenu>
	| pharoCastList |
	pharoCastList := aBuilder item: #'PharoCasts'.
	pharoCastList with: [
		self database do: [ :e | | openPharoCastItem |
			openPharoCastItem := aBuilder item: e title.
			openPharoCastItem
				action:[ e openInbrowser ]; 
				help: 'Open this PharoCast in the default browser' ] ].
]

{ #category : 'as yet unclassified' }
CwPharoCast class >> openMainPage [

	ExternalWebBrowser open: 'http://www.pharocasts.com/'.
]

{ #category : 'persistence' }
CwPharoCast class >> restoreFrom: anObject [

	database := anObject.
]

{ #category : 'persistence' }
CwPharoCast class >> spData [

	^ database
]

{ #category : 'instance creation' }
CwPharoCast class >> titled: aString [

	^ self new setTitle: aString.
]

{ #category : 'as yet unclassified' }
CwPharoCast >> at: aUrlOrString [

	url := aUrlOrString asUrl.
]

{ #category : 'as yet unclassified' }
CwPharoCast >> openInbrowser [

	ExternalWebBrowser openOnUrl: url. 
]

{ #category : 'as yet unclassified' }
CwPharoCast >> printOn: aStream [

	aStream nextPutAll: title surroundedByDoubleQuotes, ' PharoCast'.
]

{ #category : 'private' }
CwPharoCast >> setTitle: aString [ 

	title := aString.
	^ self.
]

{ #category : 'as yet unclassified' }
CwPharoCast >> title [

	^ title.
]
