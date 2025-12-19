Class {
	#name : 'GisLayer',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#instVars : [
		'server'
	],
	#category : 'ComputerWorld-GIS',
	#package : 'ComputerWorld',
	#tag : 'GIS'
}

{ #category : 'as yet unclassified' }
GisLayer class >> onServer: aGisServer fromDictionary: aDictioanry [ 
	
	^ self new
		server: aGisServer;
		rawData: aDictioanry;
		yourself
]

{ #category : 'as yet unclassified' }
GisLayer >> client [
	| client |
	client := ZnClient new
			contentReader: [ :str | STONJSON fromString: str ];
			yourself.
	^ client
]

{ #category : 'as yet unclassified' }
GisLayer >> count [

	| aUrl jsonResponse |
	aUrl := self queryUrl
			queryAt: #returnCountOnly put: true;
			yourself.

	jsonResponse := self client
		url: aUrl;
		get.

	^ jsonResponse at: #count
]

{ #category : 'as yet unclassified' }
GisLayer >> displayStringOn: aStream [

	aStream
		nextPutAll: self name
]

{ #category : 'as yet unclassified' }
GisLayer >> features [

	^ (self queryData at: #features)
]

{ #category : 'as yet unclassified' }
GisLayer >> featuresAs: aClass [ 
	
	^ self features collect: [ :aDict | aClass fromDictionary: aDict ]
]

{ #category : 'as yet unclassified' }
GisLayer >> id [

	^ self rawDataAt: #id
]

{ #category : 'as yet unclassified' }
GisLayer >> name [

	^ self rawDataAt: #name
]

{ #category : 'as yet unclassified' }
GisLayer >> objectIDs [


]

{ #category : 'as yet unclassified' }
GisLayer >> printOn: aStream [

	self printFromDisplayStringOn: aStream
]

{ #category : 'as yet unclassified' }
GisLayer >> queryData [
	| queryResponse aUrl jsonResponse |
	self rawData at: #queryResponse ifPresent: [ :resp | ^ resp ].

	self queryDataReset.

	0 to: self count by: 1000 do: [ :offset | 
		| existingFeatures newFeatures |
		aUrl := self queryUrl
				queryAt: #resultOffset put: offset;
				yourself.

		jsonResponse := self client
				url: aUrl;
				get.

		self rawData
			at: #queryResponse
			ifPresent: [ :aDict | 
				existingFeatures := aDict at: #features.
				newFeatures := jsonResponse at: #features.
				existingFeatures addAll: newFeatures ]
			ifAbsentPut: [ existingFeatures := jsonResponse at: #features.
				jsonResponse at: #features put: existingFeatures asOrderedCollection.
				jsonResponse ] ].

	^ self rawData at: #queryResponse
]

{ #category : 'as yet unclassified' }
GisLayer >> queryDataReset [
	
	self rawData removeKey: #queryResponse ifAbsent: []
]

{ #category : 'as yet unclassified' }
GisLayer >> queryUrl [

	^ self url / 'query'
		queryAt: 'where' put:'1=1';
		queryAt: 'outFields' put:'*';
		queryAt: 'outSR' put: '4326';
		queryAt: 'f' put: 'json'.
]

{ #category : 'accessing' }
GisLayer >> server [
	^ server
]

{ #category : 'accessing' }
GisLayer >> server: anObject [
	server := anObject
]

{ #category : 'as yet unclassified' }
GisLayer >> url [

	^ self server url / self id asString
]
