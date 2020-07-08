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

{ #category : #accessing }
CwNAS class >> endOfLifeList [
	<script>

	^ 'https://www.qnap.com/th-th/product/eol.php' asUrl open.
]

{ #category : #'as yet unclassified' }
CwNAS class >> modelParser [ 
	^ $T asParser, $V asParser optional, $S asParser, $- asParser, #digit asParser, #digit asParser plus flatten, #any asParser plus optional.
]

{ #category : #persistence }
CwNAS class >> restoreFrom: aCollection [

	self db: aCollection.
]

{ #category : #persistence }
CwNAS class >> spData [

	^ DB
]

{ #category : #'as yet unclassified' }
CwNAS class >> supportsDirectConnection: model [
	"E.g. via USB-B (look for a port on the lower left front) or Thunberbolt. TS-x51A series allow direct connection via USB from the NAS to your workstation. Our Thunderbolt series including the TVS-871T (https://www.qnap.com/static/landing/perfect_combo/index.html)
	
	Example:
		CwNAS supportsDirectConnection: 'TS-231p' >>> false.
		CwNAS supportsDirectConnection: 'TS-251A' >>> true.
		CwNAS supportsDirectConnection: 'TVS-472XT' >>> true.
		
	NB: Analyzing model numbers is not generally useful because apparently QNAP is inconsistent in their naming policy (see https://forum.qnap.com/viewtopic.php?t=141223)"
	
	| tokens |
	tokens := self modelParser parse: model.
	^ tokens sixth = '51' or: [ tokens seventh includes: $T ].
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

{ #category : #actions }
CwNAS >> connectAdHocTo: aNAS [

	Smalltalk tools workspace openContents: 'Assign the TVS-1282 a static IP address on the 10G port to
192.168.2.3 with a subnet mask of 255.255.255.0. Now make the 670Pro 10G port a static IP address of 192.168.2.4 with subnet mask 255.255.255.0
Install Hybrid Backup Sync on both systems. The 670Pro is your backup unit, and the 1282 is the master. Enable backup on the 670 Pro Hybrid Backup Sync. On the Master run Hybrid Backup Sync - Backup, and do a REMOTE BACKUP - enter the name, password, and static IP address of the backup QNAP (192.168.2.4) - select the folders you want to backup, and it starts. (from https://www.reddit.com/r/qnap/comments/b82zi0/10_gbe_direct_connection_between_two_nas/ejvmx8y?utm_source=share&utm_medium=web2x)'
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
