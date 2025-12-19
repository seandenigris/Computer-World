"
# iPhone
## Backup?
First, decide if *backup* is what you really want to do. The iPhone stores photos in a complex directory structure unrelated to the domain of photos. Do you want to just copy that implementation detail over to another location? Also, in what circumstances would you *restore* the photos back to the device. Probably what most users want to do is *import* photos from the phone to another device, like a computer, external disk, or NAS.

However, if you're sure you want to *backup*. Here's the (unsettling) situation...

When you plug an iPhone into the front USB port, a dialog appears on the phone confirming that you want the NAS to access your photos and videos. After confirmation, the iPhone shows up as a shared folder. So far, so good! Not so fast...

You theoretically should be able to use Hybrid Backup Sync by just specifying the phone as the source folder. However, for some reason, the backup job seems to intermittently slow to a crawl and then fail.

No matter what method you try, the first annoyance is that each time the phone mounts, the only user with access will be root (which you disabled, right?!). If you administer from a non-root user, you'll have to add that user **every time you plug the phone in**.

Now, you may think, ""I'm a superuser. I'll just use `rsync`"" to create my own backup system. Not quite. The version of rsync on your box is likely to be well behind the current version. If you still feel like you want to do this, please note one essential prerequisite: In your iPhone settings, go to ""Photos"" -> ""Transfer to Mac or PC"" and set it to ""Keep Originals"". Otherwise, you might lose a night or two of sleep...

Here's what happens if you don't ensure the ""Keep Originals"" setting. It seems to throw lots of random errors (e.g. `rsync: read errors mapping... No data available`) for which there doesn't seem to be any good explanation via google. You might start doubting your own reality, knowing that you successfully used rsync on a Mac by using mounted SMB shares for the source and destination, but have now spent a day trying to reproduce that and could not. Barely a file or two would copy and then the share kept unmounting. WTH. 

Good thing you avoided that!
## Lepiter Documentation
The following topics are covered in the Lepiter DB (unfortunately Lepiter links do not work here):
- Shared Folders
# Time Machine
For TM to ""see"" the shared folder as a destination, you must mount it e.g. via QFinder or `mount` from the command line.
After [setting up](https://www.qnap.com/en/how-to/tutorial/article/using-time-machine-to-back-up-your-mac-to-a-qnap-nas-via-smb), it's pretty much seemless. There is alot of noise on the web about TM on NAS not being reliable, but that seems to have only been the case pre-SMB. 

On reconnecting via Thunderbolt, do one of the following to make the disk available to TM:
- Map Network Drives (e.g. from QFinder)
- Login via the web interface (will this work?)

"
Class {
	#name : 'CwQnapNAS',
	#superclass : 'CwServer',
	#instVars : [
		'osVersion'
	],
	#category : 'ComputerWorld-Networking',
	#package : 'ComputerWorld',
	#tag : 'Networking'
}

{ #category : 'accessing' }
CwQnapNAS class >> endOfLifeList [
	<script>

	^ 'https://www.qnap.com/th-th/product/eol.php' asUrl open.
]

{ #category : 'examples' }
CwQnapNAS class >> exampleModel: aString [
	^ self new
			model: aString;
			manufacturer: 'QNAP';
			yourself
]

{ #category : 'accessing' }
CwQnapNAS class >> exampleTS262 [
	<gtExample>
	
	| result |
	result := self exampleModel: 'TS-262'.
	^ self exampleConfigureServer: result
]

{ #category : 'accessing' }
CwQnapNAS class >> modelParser [ 
	^ ($T asPParser, $V asPParser optional, $S asPParser) flatten, $- asPParser, #digit asPParser plus flatten, #any asPParser plus optional.
]

{ #category : 'misc' }
CwQnapNAS >> browseAppCenter [
	| modelMap url |
	modelMap := { 
		'TS-231P' -> 258.
		'TVS-472XT' -> 355.
		'TS-262' -> 597 } asDictionary.
		
	url := 'https://www.qnap.com/en/app_center/?os=qts' asUrl ? (#version -> self osVersion).
	modelMap at: self model ifPresent: [ :code | url queryAt: 'II' put: code ].
	url open
]

{ #category : 'misc' }
CwQnapNAS >> browseDownloadCenter [
	self flag: 'This may go away. We are experimenting with more open-ended, general API coupled with GT e.g. `aServer downloadCenter open` instead of `aServer downloadCenter`, because it''s just one more token *or* presumably, you''d already have a common task like `#open` in the next miller column'.
	self downloadCenter open
]

{ #category : 'misc' }
CwQnapNAS >> defaultRootPassword [
	^ self macAddress copyWithout: $:
]

{ #category : 'misc' }
CwQnapNAS >> downloadCenter [
	^ 'https://www.qnap.com/en-us/download' asUrl
		queryAt: 'model' put: self model;
		yourself.
]

{ #category : 'as yet unclassified' }
CwQnapNAS >> editAutorunDotSh [
	"Reference: https://wiki.qnap.com/wiki/Running_Your_Own_Application_at_Startup"
	
	| modelTokens isALBased contents isHALBasedIntelOrAMD |
	modelTokens := self class modelParser parse: self model.
	isALBased := modelTokens first = 'TS' and: [ modelTokens third endsWith: '31' ].
	isALBased ifTrue: [ 
		contents := 'ubiattach -m 6 -d 2
/bin/mount -t ubifs ubi2:config /tmp/config
vi /tmp/config/autorun.sh
chmod +x /tmp/config/autorun.sh
echo .
echo "unmounting /tmp/config..."
umount /tmp/config
ubidetach -m 6' ].
	self flag: 'This next line only covers one model, but there are a lot more'.
	isHALBasedIntelOrAMD := modelTokens first = 'TVS' and: [ modelTokens third endsWith: '72' ].
	isHALBasedIntelOrAMD ifTrue: [ 
			contents := 'mount $(/sbin/hal_app --get_boot_pd port_id=0)6 /tmp/config
touch /tmp/config/autorun.sh
chmod +x /tmp/config/autorun.sh
$EDITOR /tmp/config/autorun.sh
umount /tmp/config' ].
	Smalltalk tools workspace openContents: contents
]

{ #category : 'testing' }
CwQnapNAS >> isHAL [
	"https://www.qnap.com/en/how-to/knowledge-base/article/how-to-check-if-your-qts-is-legacy-or-hal-type/"
	^ (UIManager default request: 'Does the following return 0?' initialAnswer: 'ls /sbin/hal_app') isNotNil
]

{ #category : 'accessing' }
CwQnapNAS >> osVersion [

	^ osVersion
]

{ #category : 'accessing' }
CwQnapNAS >> osVersion: anObject [

	osVersion := anObject
]

{ #category : 'misc' }
CwQnapNAS >> persistSudoerEntry: entry inFileNamed: aString [
	| template command |
	template := 'echo "{entry}" > /usr/etc/sudoers.d/{filename}'.
	command := template format: { #entry -> entry asString. #filename -> aString } asDictionary.
	
	Smalltalk tools workspace openContents: 'Options:
	- Add to autorun.sh [1]: 
		', command, '
	- Apparently another solution is to install sudo via entware [2]
	
	1. https://forum.qnap.com/viewtopic.php?t=143966#p689236
	2. https://forum.qnap.com/viewtopic.php?t=152969
	3. https://superuser.com/a/1570245'.
]

{ #category : 'magritte-accessing' }
CwQnapNAS >> rootUserDescription [
	^ super rootUserDescription
			default: SuUnixUser exampleAdmin;
			yourself
]

{ #category : 'misc' }
CwQnapNAS >> sampleAutorunDotSh [

	'mkdir -p /usr/etc/sudoers.d
echo "%administrators ALL=(ALL) ALL" > /usr/etc/sudoers.d/administrators' withUnixLineEndings.
]

{ #category : 'misc' }
CwQnapNAS >> sampleAutorunDotShUnencryptedDisk [

	'#!/bin/sh
# Run with generic shell per https://stackoverflow.com/a/5725402

# Run script in same (i.e. not a new) shell as this one per https://superuser.com/a/176788/84195
source /share/homes/admin/autorun.sh' withUnixLineEndings.
]

{ #category : 'misc' }
CwQnapNAS >> sampleSudoersDotDFile [

	'%administrators ALL=(ALL) ALL' withUnixLineEndings.
]

{ #category : 'accessing' }
CwQnapNAS >> smbMountHomeForUser: aString viaAdapterWhere: aBlock [

	| adapter |
	adapter := self adapters detect: aBlock.

	^ CwMac current smbMounter
		argumentAt: #user put: aString;
		argumentAt: #server put: adapter ipAddress printString;
		argumentAt: #share put: 'home';
		run
]

{ #category : 'accessing' }
CwQnapNAS >> sudoersFile [
	"As of QTS 4.3.3. per https://superuser.com/a/1299662"
	^ '/usr/etc/sudoers' asFileReference.
]

{ #category : 'testing' }
CwQnapNAS >> supportsDirectConnection [
	"E.g. via USB-B (look for a port on the lower left front) or Thunberbolt. TS-x51A series allow direct connection via USB from the NAS to your workstation. Our Thunderbolt series including the TVS-871T (https://www.qnap.com/static/landing/perfect_combo/index.html)
	
	Example:
		(CwQnapNAS exampleModel: 'TS-231P') supportsDirectConnection >>> false.
		(CwQnapNAS exampleModel: 'TS-251A') supportsDirectConnection >>> true.
		(CwQnapNAS exampleModel: 'TVS-472XT') supportsDirectConnection >>> true.
		
	NB: Analyzing model numbers is not generally useful because apparently QNAP is inconsistent in their naming policy (see https://forum.qnap.com/viewtopic.php?t=141223)"
	
	| tokens |
	tokens := self class modelParser parse: model.
	^ (tokens third endsWith: '51') or: [ tokens fourth includes: $T ].
]
