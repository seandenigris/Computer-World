Class {
	#name : #GisLayer,
	#superclass : #Object,
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#instVars : [
		'server',
		'queryData'
	],
	#category : #'ComputerWorld-GIS'
}

{ #category : #'as yet unclassified' }
GisLayer class >> onServer: aGisServer fromDictionary: aDictioanry [ 
	
	^ self new
		server: aGisServer;
		rawData: aDictioanry;
		yourself
]

{ #category : #'as yet unclassified' }
GisLayer >> displayStringOn: aStream [

	aStream
		nextPutAll: self name
]

{ #category : #'as yet unclassified' }
GisLayer >> features [

	^ (self queryData at: #features)
]

{ #category : #'as yet unclassified' }
GisLayer >> featuresAs: aClass [ 
	
	^ self features collect: [ :aDict | aClass fromDictionary: aDict ]
]

{ #category : #'as yet unclassified' }
GisLayer >> id [

	^ self rawDataAt: #id
]

{ #category : #'as yet unclassified' }
GisLayer >> name [

	^ self rawDataAt: #name
]

{ #category : #'as yet unclassified' }
GisLayer >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : #'as yet unclassified' }
GisLayer >> queryData [

	| queryResponse aUrl |
	
	self rawData 
		at: #queryResponse
		ifPresent: [ :resp | ^ resp ].
	
	aUrl := self url / 'query'
		queryAt: 'where' put:'1=1';
		queryAt: 'outSR' put: '4326';
		queryAt: 'f' put: 'json'.
		
	queryResponse := ZnClient new
		url: aUrl;
		contentReader: [ :str | STONJSON fromString: str ];
		get.
		
	^ self rawData at: #queryResponse put: queryResponse
]

{ #category : #accessing }
GisLayer >> server [
	^ server
]

{ #category : #accessing }
GisLayer >> server: anObject [
	server := anObject
]

{ #category : #'as yet unclassified' }
GisLayer >> url [

	^ self server url / self id asString
]
