Class {
	#name : #CwQnapNAS,
	#superclass : #CwServer,
	#category : #'ComputerWorld-NAS'
}

{ #category : #accessing }
CwQnapNAS class >> endOfLifeList [
	<script>

	^ 'https://www.qnap.com/th-th/product/eol.php' asUrl open.
]

{ #category : #examples }
CwQnapNAS class >> exampleModel: aString [
	^ self new
			model: aString;
			manufacturer: 'QNAP';
			yourself
]

{ #category : #accessing }
CwQnapNAS class >> modelParser [ 
	^ ($T asParser, $V asParser optional, $S asParser) flatten, $- asParser, #digit asParser plus flatten, #any asParser plus optional.
]

{ #category : #misc }
CwQnapNAS >> browseAppCenter [
	| modelMap url |
	modelMap := { 
		'TS-231P' -> 258.
		'TVS-472XT' -> 355 } asDictionary.
		
	url := 'https://www.qnap.com/en/app_center/?os=qts&version=4.4.3' asUrl.
	modelMap at: self model ifPresent: [ :code | url queryAt: 'II' put: code ].
	url open
]

{ #category : #misc }
CwQnapNAS >> defaultRootPassword [
	^ self macAddress copyWithout: $:
]

{ #category : #'as yet unclassified' }
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

{ #category : #testing }
CwQnapNAS >> isHAL [
	"https://www.qnap.com/en/how-to/knowledge-base/article/how-to-check-if-your-qts-is-legacy-or-hal-type/"
	^ (UIManager default request: 'Does the following return 0?' initialAnswer: 'ls /sbin/hal_app') isNotNil
]

{ #category : #misc }
CwQnapNAS >> persistSudoerEntry: entry inFileNamed: aString [
	| template command |
	template := 'echo "{entry}" > /usr/etc/sudoers.d/{filename}'.
	command := template format: { #entry -> entry asString. #filename -> aString } asDictionary.
	
	Smalltalk tools workspace openContents: 'Options:
	- Add to autorun.sh [1]: 
		', command, '
	- Apparently another solution is to install sudo via entware [2]
	
	1. https://forum.qnap.com/viewtopic.php?t=143966#p689236
	2. https://forum.qnap.com/viewtopic.php?t=152969'.
]

{ #category : #'magritte-accessing' }
CwQnapNAS >> rootUserDescription [
	| root |
	root := CwUnixUser new
		name: 'admin';
		yourself.
	^ super rootUserDescription
			default: root;
			yourself
]

{ #category : #misc }
CwQnapNAS >> sampleAutorunDotSh [

	'mkdir -p /usr/etc/sudoers.d
echo "%administrators ALL=(ALL) ALL" > /usr/etc/sudoers.d/administrators' withUnixLineEndings.
]

{ #category : #misc }
CwQnapNAS >> sampleAutorunDotShUnencryptedDisk [

	'#!/bin/sh
# Run with generic shell per https://stackoverflow.com/a/5725402

# Run script in same (i.e. not a new) shell as this one per https://superuser.com/a/176788/84195
source /share/homes/admin/autorun.sh' withUnixLineEndings.
]

{ #category : #misc }
CwQnapNAS >> sampleSudoersDotDFile [

	'%administrators ALL=(ALL) ALL' withUnixLineEndings.
]

{ #category : #accessing }
CwQnapNAS >> sudoersFile [
	"As of QTS 4.3.3. per https://superuser.com/a/1299662"
	^ '/usr/etc/sudoers' asFileReference.
]

{ #category : #testing }
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

{ #category : #misc }
CwQnapNAS >> timeMachineSetup [
	Smalltalk tools webBrowser new open: 'https://www.qnap.com/en/how-to/tutorial/article/using-time-machine-to-back-up-your-mac-to-a-qnap-nas-via-smb' asUrl
]
