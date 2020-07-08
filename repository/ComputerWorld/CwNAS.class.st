Class {
	#name : #CwNAS,
	#superclass : #Object,
	#instVars : [
		'adapters',
		'model',
		'manufacturer'
	],
	#classVars : [
		'DB'
	],
	#category : #'ComputerWorld-NAS'
}

{ #category : #accessing }
CwNAS class >> db [
	^ DB ifNil: [ DB := OrderedCollection new ]
]

{ #category : #accessing }
CwNAS class >> db: aCollection [
	DB := aCollection
]

{ #category : #persistence }
CwNAS class >> restoreFrom: aCollection [

	self db: aCollection.
]

{ #category : #persistence }
CwNAS class >> spData [

	^ DB
]

{ #category : #accessing }
CwNAS >> adapters [
	^ self maLazyFrom: self adaptersDescription
]

{ #category : #accessing }
CwNAS >> adapters: aCollection [
	adapters := aCollection
]

{ #category : #'magritte-accessing' }
CwNAS >> adaptersDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #adapters;
		classes:
			(Set new
				add: CwNetworkAdapter;
				yourself);
		priority: 300;
		yourself
]

{ #category : #accessing }
CwNAS >> manufacturer [
	^ self maLazyFrom: self manufacturerDescription
]

{ #category : #accessing }
CwNAS >> manufacturer: aString [
	manufacturer := aString
]

{ #category : #'magritte-accessing' }
CwNAS >> manufacturerDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #manufacturer;
		priority: 200;
		yourself
]

{ #category : #accessing }
CwNAS >> model [
	^ self maLazyFrom: self modelDescription
]

{ #category : #accessing }
CwNAS >> model: aString [
	model := aString
]

{ #category : #'magritte-accessing' }
CwNAS >> modelDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #model;
		priority: 100;
		yourself
]

{ #category : #printing }
CwNAS >> printOn: aStream [
	aStream
		nextPutAll: model;
		nextPutAll: ' (', manufacturer, ')'
]
