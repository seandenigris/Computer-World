"
Commands adapted from http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html

# Target

## Other files
You can have other files in the destination. TM will not disturb them, but will happily create a sparsebundle alongside them.

## IP Address changes
Time Machine stores metainfo about the backup on the target, not the source, so you can just remove the target with the old IP and add a new one with the new IP. TM will recognize the backup and keep adding to it, preserving the history.

## NAS Backups
You can encrypt NAS backups ([per 9to5mac](https://9to5mac.com/2020/08/20/how-to-easily-back-up-your-mac-with-time-machine-and-a-synology-nas-video/)). Learn a bit more about what that means on [this stack exchange thread](https://apple.stackexchange.com/questions/378394/how-does-time-machine-encrypt-backups-to-network-disk)
"
Class {
	#name : #CwTimeMachine,
	#superclass : #Object,
	#category : #'ComputerWorld-TimeMachine'
}

{ #category : #accessing }
CwTimeMachine class >> destinationInfoCommand [
	^ 'tmutil destinationinfo -X' asSuCommand
]

{ #category : #accessing }
CwTimeMachine class >> destinations [
	^ CwTimeMachineDestination all
]

{ #category : #'as yet unclassified' }
CwTimeMachine class >> optimumSpaceToBackupGB: aNumber [
	"From http://apple.stackexchange.com/questions/100780/how-big-should-my-time-machine-backup-drive-be"
	
	^ 2 * aNumber to: 4 * aNumber
]

{ #category : #accessing }
CwTimeMachine class >> setQuotaCommand [
	^ 'tmutil setquota {destinationID} {quotaGB}' asSuCommand asRoot
]

{ #category : #accessing }
CwTimeMachine class >> startBackupToCommand [
	^ 'tmutil startbackup --destination {destinationID}' asSuCommand
]

{ #category : #accessing }
CwTimeMachine class >> stopBackupCommand [
	^ 'tmutil stopbackup' asSuCommand
]

{ #category : #actions }
CwTimeMachine >> disableCommand [
	^ 'tmutil disable' asSuCommand asRoot
]

{ #category : #actions }
CwTimeMachine >> disableLocalSnapshotsCommand [
	^ 'tmutil disablelocal' asSuCommand asRoot
]

{ #category : #actions }
CwTimeMachine >> enableCommand [
	^ 'tmutil enable' asSuCommand asRoot
]

{ #category : #actions }
CwTimeMachine >> enableLocalSnapshotsCommand [
	^ 'tmutil enablelocal' asSuCommand asRoot
]

{ #category : #actions }
CwTimeMachine >> exclude: file [
	"Sticky (i.e. follows moved files). Add -p flag for unsticky
	
	Motivation: Items such as scratch disks, backups, caches, and Lightroom previews should be excluded because they are unnecessary 
	
	Reference: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ ('tmutil addexclusion', file) asSuCommand asRoot
]

{ #category : #accessing }
CwTimeMachine >> inheritBackup: aFileReference [
	"NB. the new Mac will still backup *its entire disk*, but you will have access to files/versions that were on the old machine but not the new machine.
	
	aFileReference - either a local Backups.backupdb or a mounted sparsebundle
	
	Reference: http://www.creativetechsupport.com/help/it/install/timemachine-inherit.html"
	^ SuGenericUnixCommand new
		asRoot;
		template: 'tmutil inheritbackup {backup}';
		argumentAt: #backup put: aFileReference
]

{ #category : #actions }
CwTimeMachine >> isExcluded: file [
	"From: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ 'tmutil isexcluded' asSuCommand, file
]

{ #category : #accessing }
CwTimeMachine >> isRunning [
	^ (self statusCommand output at: #Running) = 1
]

{ #category : #accessing }
CwTimeMachine >> percentComplete [
	"Seems to be only available when not running"
	^ self statusCommand output at: #Percent
]

{ #category : #actions }
CwTimeMachine >> statusCommand [
	^ 'tmutil status' asSuCommand
		outputDecoder: [ :str | 
			| headerLine |
			headerLine := #newline asPParser negate plus, #newline asPParser.
			(headerLine, CwPList nextStepParser ==> #last) parse: str ];
		yourself
]
