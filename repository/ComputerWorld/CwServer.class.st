"
# Database

The server database lives on my class-side. One way to view it is:
```
CwServer db
```

Or, it is available in Coder via my ""Servers"" tab:

![Screen Shot 2021-04-30 at 10 03 53 AM](https://user-images.githubusercontent.com/184176/116708691-f593dd00-a99d-11eb-88cc-cc27f3c21a94.png)


"
Class {
	#name : 'CwServer',
	#superclass : 'CwNetworkDevice',
	#instVars : [
		'adminUser',
		'rootUser',
		'rsaKeyFingerprint'
	],
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'examples' }
CwServer class >> exampleConfigureServer: aCwServer [
	
	aCwServer adapters add: CwNetworkAdapter example.
	
	^ aCwServer
		rsaKeyFingerprint: 'abc123XYZ';
		macAddress: CwMACAddress example;
		name: 'My Server';
		propertyAt: 'pin code' put: 1234;
		adminUser: SuUnixUser exampleAdmin;
		yourself
]

{ #category : 'examples' }
CwServer class >> exampleRouter [
	^ CwServer new
			name: 'Home Router';
			rootUser: SuUnixUser exampleAdmin;
			yourself.
]

{ #category : 'examples' }
CwServer class >> exampleServer [
	<gtExample>
	
	| result |
	result := self new.
	result adapters add: CwNetworkAdapter example.
	
	^ result
		rsaKeyFingerprint: 'abc123XYZ';
		macAddress: CwMACAddress example;
		name: 'My Server';
		propertyAt: 'pin code' put: 1234;
		adminUser: SuUnixUser exampleAdmin;
		yourself
]

{ #category : 'accessing' }
CwServer >> adminUser [
	^ self maLazyInstVarUsing: self adminUserDescription
]

{ #category : 'accessing' }
CwServer >> adminUser: aString [
	adminUser := aString
]

{ #category : 'magritte-accessing' }
CwServer >> adminUserDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #adminUser;
		classes: { SuUnixUser };
		priority: 250;
		yourself
]

{ #category : 'actions' }
CwServer >> connectAdHocTo: aNAS [

	Smalltalk tools workspace openContents: 'Assign the TVS-1282 a static IP address on the 10G port to
192.168.2.3 with a subnet mask of 255.255.255.0. Now make the 670Pro 10G port a static IP address of 192.168.2.4 with subnet mask 255.255.255.0
Install Hybrid Backup Sync on both systems. The 670Pro is your backup unit, and the 1282 is the master. Enable backup on the 670 Pro Hybrid Backup Sync. On the Master run Hybrid Backup Sync - Backup, and do a REMOTE BACKUP - enter the name, password, and static IP address of the backup QNAP (192.168.2.4) - select the folders you want to backup, and it starts. (from https://www.reddit.com/r/qnap/comments/b82zi0/10_gbe_direct_connection_between_two_nas/ejvmx8y?utm_source=share&utm_medium=web2x)'
]

{ #category : 'accessing' }
CwServer >> fingerprintFromKnownPublicKey [
	^ (SuSSHKeyGen knownPublicKeyFingerprintForHost: self adapters first ipAddress asString) output
]

{ #category : 'accessing' }
CwServer >> logIn [
	self error: 'WIP - have to consider all devices, not just default network'.
	^ self adapters detect: [ :e | e ipAddress ifNotNil: [ :a | CwMac current defaultNetwork includes: a ] ifNil: [ false ] ]
]

{ #category : 'accessing' }
CwServer >> reachableAdapter [
	| activeOsAdapters |
	^ self adapters
		detect: [ :myAdapter | 
			activeOsAdapters := OSPlatform current networkAdapters
					select: [ :osAdapter | osAdapter ipAddress isNotNil ].
			activeOsAdapters
				anySatisfy: [ :osAdapter | myAdapter ipAddress isOnSubnet: myAdapter subnetMask with: osAdapter ipAddress ] ]
]

{ #category : 'accessing' }
CwServer >> rootUser [
	^ self maLazyInstVarUsing: self rootUserDescription
]

{ #category : 'accessing' }
CwServer >> rootUser: anObject [
	rootUser := anObject
]

{ #category : 'magritte-accessing' }
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

{ #category : 'accessing' }
CwServer >> rsaKeyFingerprint [
	^ self maLazyInstVarUsing: self rsaKeyFingerprintDescription
]

{ #category : 'accessing' }
CwServer >> rsaKeyFingerprint: aString [
	rsaKeyFingerprint := aString
]

{ #category : 'magritte-accessing' }
CwServer >> rsaKeyFingerprintDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #rsaKeyFingerprint;
		yourself
]

{ #category : 'ssh' }
CwServer >> sshAdmin [
	self sshAs: self adminUser
]

{ #category : 'ssh' }
CwServer >> sshAs: user [
	
	self sshAs: user on: self reachableAdapter
]

{ #category : 'ssh' }
CwServer >> sshAs: user on: aNetworkAdapter [
	CwTerminal new doScript: 'ssh ', user name, '@', aNetworkAdapter ipAddress asString.
]

{ #category : 'ssh' }
CwServer >> sshRoot [
	self sshAs: self rootUser
]

{ #category : 'misc' }
CwServer >> timeMachineDIYSetup [
	Smalltalk tools webBrowser new open: 'https://netfuture.ch/2013/08/simple-versioned-timemachine-like-backup-using-rsync/' asUrl
]

{ #category : 'accessing' }
CwServer >> wakeOnLAN [
	| hexString packet |
	self error: 'How do we figure out which adapter is on the same network? For now send this directly to the adapter'.
]
