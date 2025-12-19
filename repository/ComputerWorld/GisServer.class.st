Class {
	#name : 'GisServer',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#instVars : [
		'url'
	],
	#category : 'ComputerWorld-GIS',
	#package : 'ComputerWorld',
	#tag : 'GIS'
}

{ #category : 'as yet unclassified' }
GisServer class >> fromUrl: aUrl [ 
		
	^ self new
		url: aUrl;
		yourself
]

{ #category : 'as yet unclassified' }
GisServer >> layers [

	^ self 
		rawDataAt: #layers
		reader: [ :aCol | aCol collect: [ :aDict |
			GisLayer 
				onServer: self
				fromDictionary: aDict ] ]
]

{ #category : 'as yet unclassified' }
GisServer >> nrParcelLayer [

	^ self layers detect: [ :layer | layer name = 'Parcels' ]
]

{ #category : 'as yet unclassified' }
GisServer >> spatialReferenceID [
	
	^ (self rawData at: 'spatialReference') at: 'latestWkid'
	
	"Implementation note: there is also wkid"
]

{ #category : 'accessing' }
GisServer >> url [
	^ url
]

{ #category : 'accessing' }
GisServer >> url: anObject [

	| json |
	url := anObject.
	
	json := ZnClient new
		url: (self url queryAt: 'f' put: 'json');
		contentReader: [ :str | STONJSON fromString: str ];
		get.
		
	self rawData: json
]
