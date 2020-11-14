Class {
	#name : #CwServer,
	#superclass : #Object,
	#instVars : [
		'adapters',
		'manufacturer',
		'model',
		'adminUser',
		'rootUser',
		'macAddress',
		'name',
		'rsaKeyFingerprint'
	],
	#classVars : [
		'DB'
	],
	#category : #'ComputerWorld-NAS'
}

{ #category : #accessing }
CwServer class >> db [
	^ DB ifNil: [ DB := OrderedCollection new ]
]

{ #category : #accessing }
CwServer class >> db: aCollection [
	DB := aCollection
]

{ #category : #accessing }
CwServer class >> exampleRouter [
	^ CwServer new
			name: 'Home Router';
			rootUser: SuUnixUser exampleAdmin;
			yourself.
]

{ #category : #persistence }
CwServer class >> restoreFrom: aCollection [

	self db: aCollection.
]

{ #category : #persistence }
CwServer class >> spData [

	^ DB
]

{ #category : #accessing }
CwServer >> adapters [
	^ self maLazyInstVarUsing: self adaptersDescription
]

{ #category : #accessing }
CwServer >> adapters: aCollection [
	adapters := aCollection
]

{ #category : #'magritte-accessing' }
CwServer >> adaptersDescription [
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
CwServer >> adminUser [
	^ self maLazyInstVarUsing: self adminUserDescription
]

{ #category : #accessing }
CwServer >> adminUser: aString [
	adminUser := aString
]

{ #category : #'magritte-accessing' }
CwServer >> adminUserDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #adminUser;
		classes: { SuUnixUser };
		priority: 250;
		yourself
]

{ #category : #actions }
CwServer >> connectAdHocTo: aNAS [

	Smalltalk tools workspace openContents: 'Assign the TVS-1282 a static IP address on the 10G port to
192.168.2.3 with a subnet mask of 255.255.255.0. Now make the 670Pro 10G port a static IP address of 192.168.2.4 with subnet mask 255.255.255.0
Install Hybrid Backup Sync on both systems. The 670Pro is your backup unit, and the 1282 is the master. Enable backup on the 670 Pro Hybrid Backup Sync. On the Master run Hybrid Backup Sync - Backup, and do a REMOTE BACKUP - enter the name, password, and static IP address of the backup QNAP (192.168.2.4) - select the folders you want to backup, and it starts. (from https://www.reddit.com/r/qnap/comments/b82zi0/10_gbe_direct_connection_between_two_nas/ejvmx8y?utm_source=share&utm_medium=web2x)'
]

{ #category : #accessing }
CwServer >> macAddress [
	^ self adapters 
			ifNotEmpty: [ :col | col first macAddress ]
			ifEmpty: [ nil ]
]

{ #category : #accessing }
CwServer >> macAddress: aString [
	self adapters ifEmpty: [ self adapters add: CwNetworkAdapter new ].
	self adapters first macAddress: aString
]

{ #category : #'magritte-accessing' }
CwServer >> macAddressDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #macAddress;
		comment: 'The medium access control (MAC) address that is printed on the enclosure is that of its first NIC Adapter';
		yourself
]

{ #category : #accessing }
CwServer >> manufacturer [
	^ self maLazyInstVarUsing: self manufacturerDescription
]

{ #category : #accessing }
CwServer >> manufacturer: aString [
	manufacturer := aString
]

{ #category : #'magritte-accessing' }
CwServer >> manufacturerDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #manufacturer;
		priority: 200;
		yourself
]

{ #category : #accessing }
CwServer >> model [
	^ self maLazyInstVarUsing: self modelDescription
]

{ #category : #accessing }
CwServer >> model: aString [
	model := aString
]

{ #category : #'magritte-accessing' }
CwServer >> modelDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #model;
		priority: 100;
		yourself
]

{ #category : #accessing }
CwServer >> name [
	^ self maLazyInstVarUsing: self nameDescription
]

{ #category : #accessing }
CwServer >> name: aString [
	name := aString
]

{ #category : #'magritte-accessing' }
CwServer >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		priority: 50;
		yourself
]

{ #category : #printing }
CwServer >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPutAll: ' (';
		maPrint: self modelDescription for: self;
		space;
		maPrint: self manufacturerDescription for: self;
		nextPut: $)
]

{ #category : #accessing }
CwServer >> rootUser [
	^ self maLazyInstVarUsing: self rootUserDescription
]

{ #category : #accessing }
CwServer >> rootUser: anObject [
	rootUser := anObject
]

{ #category : #'magritte-accessing' }
CwServer >> rootUserDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #rootUser;
		classes:
			(Set new
				add: SuUnixUser;
				yourself);
		yourself
]

{ #category : #accessing }
CwServer >> rsaKeyFingerprint [
	^ self maLazyInstVarUsing: self rsaKeyFingerprintDescription
]

{ #category : #accessing }
CwServer >> rsaKeyFingerprint: aString [
	rsaKeyFingerprint := aString
]

{ #category : #'magritte-accessing' }
CwServer >> rsaKeyFingerprintDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #rsaKeyFingerprint;
		yourself
]

{ #category : #ssh }
CwServer >> sshAdmin [
	self sshAs: self adminUser
]

{ #category : #ssh }
CwServer >> sshAs: user [
	| adapter |
	adapter := self adapters size = 1
		ifTrue: [ self adapters first ]
		ifFalse: [ self adapters detect: [ :e | e usage includesSubstring: 'MBP' ] ].
	CwTerminal new doScript: 'ssh ', user name, '@', adapter ipAddress asString.
]

{ #category : #ssh }
CwServer >> sshRoot [
	self sshAs: self rootUser
]

{ #category : #misc }
CwServer >> timeMachineDIYSetup [
	Smalltalk tools webBrowser new open: 'https://netfuture.ch/2013/08/simple-versioned-timemachine-like-backup-using-rsync/' asUrl
]
