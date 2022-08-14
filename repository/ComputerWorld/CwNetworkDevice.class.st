Class {
	#name : #CwNetworkDevice,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'adapters',
		'macAddress',
		'manufacturer',
		'model',
		'name'
	],
	#classVars : [
		'DB'
	],
	#category : #'ComputerWorld-Networking'
}

{ #category : #accessing }
CwNetworkDevice class >> db [
	^ DB ifNil: [ DB := OrderedCollection new ]
]

{ #category : #accessing }
CwNetworkDevice class >> db: aCollection [
	DB := aCollection
]

{ #category : #accessing }
CwNetworkDevice class >> gtViewServersOn: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Servers' translated;
		priority: 50;
		items: [ self db select: [ :serv | serv isKindOf: self ] ];
		column: 'Name' text: [ :serv | serv name ];
		column: 'Manufacturer' text: [ :serv | serv manufacturer ];
		column: 'Model' text: [ :serv | serv model ]
]

{ #category : #persistence }
CwNetworkDevice class >> restoreFrom: aCollection [

	self db: aCollection.
]

{ #category : #persistence }
CwNetworkDevice class >> spData [

	^ DB
]

{ #category : #accessing }
CwNetworkDevice >> adapters [
	^ self maLazyInstVarUsing: self adaptersDescription
]

{ #category : #accessing }
CwNetworkDevice >> adapters: aCollection [
	adapters := aCollection
]

{ #category : #'magritte-accessing' }
CwNetworkDevice >> adaptersDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #adapters;
		default: OrderedCollection new;
		classes:
			(Set new
				add: CwNetworkAdapter;
				yourself);
		priority: 300;
		yourself
]

{ #category : #accessing }
CwNetworkDevice >> ipAddress [
	| relevantAdapter |
	relevantAdapter := self adapters detect: [ :e | e isSameNetworkAs: OSPlatform current ipAddress ].
	^ relevantAdapter ipAddress
]

{ #category : #accessing }
CwNetworkDevice >> macAddress [
	^ self adapters 
			ifNotEmpty: [ :col | col first macAddress ]
			ifEmpty: [ nil ]
]

{ #category : #accessing }
CwNetworkDevice >> macAddress: aString [
	self adapters ifEmpty: [ self adapters add: CwNetworkAdapter new ].
	self adapters first macAddress: aString
]

{ #category : #'magritte-accessing' }
CwNetworkDevice >> macAddressDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #macAddress;
		comment: 'The medium access control (MAC) address that is printed on the enclosure is that of its first NIC Adapter';
		classes: { CwMACAddress };
		reference: (CwMACAddress new magritteDescription display: [ :e | Halt once. e displayString ]);
		yourself
]

{ #category : #accessing }
CwNetworkDevice >> manufacturer [
	^ self maLazyInstVarUsing: self manufacturerDescription
]

{ #category : #accessing }
CwNetworkDevice >> manufacturer: aString [
	manufacturer := aString
]

{ #category : #'magritte-accessing' }
CwNetworkDevice >> manufacturerDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #manufacturer;
		priority: 200;
		yourself
]

{ #category : #accessing }
CwNetworkDevice >> model [
	^ self maLazyInstVarUsing: self modelDescription
]

{ #category : #accessing }
CwNetworkDevice >> model: aString [
	model := aString
]

{ #category : #'magritte-accessing' }
CwNetworkDevice >> modelDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #model;
		priority: 100;
		yourself
]

{ #category : #accessing }
CwNetworkDevice >> name [
	^ self maLazyInstVarUsing: self nameDescription
]

{ #category : #accessing }
CwNetworkDevice >> name: aString [
	name := aString
]

{ #category : #'magritte-accessing' }
CwNetworkDevice >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		priority: 50;
		yourself
]

{ #category : #printing }
CwNetworkDevice >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPutAll: ' (';
		maPrint: self modelDescription for: self;
		space;
		maPrint: self manufacturerDescription for: self;
		nextPut: $)
]
