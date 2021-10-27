Class {
	#name : #CwITunes,
	#superclass : #CwMacApplication,
	#category : 'ComputerWorld-Mac'
}

{ #category : #accessing }
CwITunes class >> bundleBasename [
	^ 'iTunes.app'
]

{ #category : #accessing }
CwITunes class >> iPhoneBackupFolder [
	self flag: 'Not sure what we want to do here. If it''s a link, do we want to return the target?'.
	^ self iPhoneBackupFolderDefault
]

{ #category : #accessing }
CwITunes class >> iPhoneBackupFolder: aFileReference [
	"Argument can be a mounted remote location"
	SuLn new
		original: aFileReference;
		link: self iPhoneBackupFolderDefault;
		runInTerminal.
	"Implementation note: if argument is an SMB share, #run seemed to return 256, so we use #runInTerminal"
]

{ #category : #accessing }
CwITunes class >> iPhoneBackupFolderDefault [
	^ FileLocator userApplicationSupport / 'MobileSync' / 'Backup'
]
