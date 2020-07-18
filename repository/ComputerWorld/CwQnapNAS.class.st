Class {
	#name : #CwQnapNAS,
	#superclass : #CwNAS,
	#category : #'ComputerWorld-NAS'
}

{ #category : #accessing }
CwQnapNAS class >> endOfLifeList [
	<script>

	^ 'https://www.qnap.com/th-th/product/eol.php' asUrl open.
]

{ #category : #examples }
CwQnapNAS class >> exampleModel: aString [
	^ CwNAS new
			model: aString;
			manufacturer: 'QNAP';
			yourself
]

{ #category : #accessing }
CwQnapNAS class >> modelParser [ 
	^ $T asParser, $V asParser optional, $S asParser, $- asParser, #digit asParser, #digit asParser plus flatten, #any asParser plus optional.
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

{ #category : #misc }
CwQnapNAS >> persistSudoers [
	
	Smalltalk tools workspace openContents: '"Per https://forum.qnap.com/viewtopic.php?t=143966#p689236"
	
	''echo "USERNAME ALL=(ALL) ALL" > /usr/etc/sudoers.d/USERNAME''

"Apparently another solutiono is to install sudo via entware: See https://forum.qnap.com/viewtopic.php?t=152969'.
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

{ #category : #accessing }
CwQnapNAS >> sudoersFile [
	"As of QTS 4.3.3. per https://superuser.com/a/1299662"
	^ '/usr/etc/sudoers' asFileReference.
]

{ #category : #testing }
CwQnapNAS >> supportsDirectConnection [
	"E.g. via USB-B (look for a port on the lower left front) or Thunberbolt. TS-x51A series allow direct connection via USB from the NAS to your workstation. Our Thunderbolt series including the TVS-871T (https://www.qnap.com/static/landing/perfect_combo/index.html)
	
	Example:
		(CwQnapNAS exampleQNAPModel: 'TS-231P') supportsDirectConnection >>> false.
		(CwQnapNAS exampleQNAPModel: 'TS-251A') supportsDirectConnection >>> true.
		(CwQnapNAS exampleQNAPModel: 'TVS-472XT') supportsDirectConnection >>> true.
		
	NB: Analyzing model numbers is not generally useful because apparently QNAP is inconsistent in their naming policy (see https://forum.qnap.com/viewtopic.php?t=141223)"
	
	| tokens |
	tokens := self class modelParser parse: model.
	^ tokens sixth = '51' or: [ tokens seventh includes: $T ].
]

{ #category : #misc }
CwQnapNAS >> timeMachineSetup [
	Smalltalk tools webBrowser new open: 'https://www.qnap.com/en/how-to/tutorial/article/using-time-machine-to-back-up-your-mac-to-a-qnap-nas-via-smb' asUrl
]
