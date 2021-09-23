"
Commands adapted from http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html
"
Class {
	#name : 'CwTimeMachine',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwTimeMachine class >> optimumSpaceToBackupGB: aNumber [
	"From http://apple.stackexchange.com/questions/100780/how-big-should-my-time-machine-backup-drive-be"
	
	^ 2 * aNumber to: 4 * aNumber
]

{ #category : 'actions' }
CwTimeMachine >> disableLocalSnapshots [
	'tmutil enablelocal' asSuCommand asRoot
]

{ #category : 'actions' }
CwTimeMachine >> enableLocalSnapshots [
	'tmutil enablelocal' asSuCommand asRoot run
]

{ #category : 'actions' }
CwTimeMachine >> exclude: file [
	"Sticky (i.e. follows moved files). Add -p flag for unsticky
	
	Motivation: Items such as scratch disks, backups, caches, and Lightroom previews should be excluded because they are unnecessary 
	
	Reference: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ ('tmutil addexclusion', file) asSuCommand asRoot
]

{ #category : 'actions' }
CwTimeMachine >> isExcluded: file [
	"From: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ 'tmutil isexcluded' asSuCommand, file
]
