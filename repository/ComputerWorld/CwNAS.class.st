Class {
	#name : #CwNAS,
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
CwNAS >> adminUser [
	^ self maLazyFrom: self adminUserDescription
]

{ #category : #accessing }
CwNAS >> adminUser: aString [
	adminUser := aString
]

{ #category : #'magritte-accessing' }
CwNAS >> adminUserDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #adminUser;
		classes: { CwUnixUser };
		priority: 250;
		yourself
]

{ #category : #actions }
CwNAS >> connectAdHocTo: aNAS [

	Smalltalk tools workspace openContents: 'Assign the TVS-1282 a static IP address on the 10G port to
192.168.2.3 with a subnet mask of 255.255.255.0. Now make the 670Pro 10G port a static IP address of 192.168.2.4 with subnet mask 255.255.255.0
Install Hybrid Backup Sync on both systems. The 670Pro is your backup unit, and the 1282 is the master. Enable backup on the 670 Pro Hybrid Backup Sync. On the Master run Hybrid Backup Sync - Backup, and do a REMOTE BACKUP - enter the name, password, and static IP address of the backup QNAP (192.168.2.4) - select the folders you want to backup, and it starts. (from https://www.reddit.com/r/qnap/comments/b82zi0/10_gbe_direct_connection_between_two_nas/ejvmx8y?utm_source=share&utm_medium=web2x)'
]

{ #category : #accessing }
CwNAS >> macAddress [
	^ self adapters first macAddress
]

{ #category : #accessing }
CwNAS >> macAddress: aString [
	self adapters ifEmpty: [ self adapters add: CwNetworkAdapter new ].
	self adapters first macAddress: aString
]

{ #category : #'magritte-accessing' }
CwNAS >> macAddressDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #macAddress;
		comment: 'The medium access control (MAC) address that is printed on the enclosure is that of its first NIC Adapter';
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

{ #category : #accessing }
CwNAS >> name [
	^ self maLazyFrom: self nameDescription
]

{ #category : #accessing }
CwNAS >> name: aString [
	name := aString
]

{ #category : #'magritte-accessing' }
CwNAS >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		priority: 50;
		yourself
]

{ #category : #printing }
CwNAS >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPutAll: ' (';
		nextPutAll: model;
		space;
		nextPutAll: manufacturer;
		nextPut: $)
]

{ #category : #accessing }
CwNAS >> rootUser [
	^ self maLazyFrom: self rootUserDescription
]

{ #category : #accessing }
CwNAS >> rootUser: anObject [
	rootUser := anObject
]

{ #category : #'magritte-accessing' }
CwNAS >> rootUserDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #rootUser;
		classes:
			(Set new
				add: CwUnixUser;
				yourself);
		yourself
]

{ #category : #accessing }
CwNAS >> rsaKeyFingerprint [
	^ self maLazyFrom: self rsaKeyFingerprintDescription
]

{ #category : #accessing }
CwNAS >> rsaKeyFingerprint: aString [
	rsaKeyFingerprint := aString
]

{ #category : #'magritte-accessing' }
CwNAS >> rsaKeyFingerprintDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #rsaKeyFingerprint;
		yourself
]

{ #category : #ssh }
CwNAS >> sshAdmin [
	self sshAs: self adminUser
]

{ #category : #ssh }
CwNAS >> sshAs: user [
	| adapter |
	adapter := self adapters detect: [ :e | e usage includesSubstring: 'MBP' ].
	CwTerminal new doScript: 'ssh ', user name, '@', adapter ipAddress.
]

{ #category : #ssh }
CwNAS >> sshRoot [
	self sshAs: self rootUser
]

{ #category : #misc }
CwNAS >> timeMachineDIYSetup [
	Smalltalk tools webBrowser new open: 'https://netfuture.ch/2013/08/simple-versioned-timemachine-like-backup-using-rsync/' asUrl
]
