"
Control time machine from the Mac command line.

There are a few more commands that haven't been implemented. See [here](https://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html) for more info.

"
Class {
	#name : #CwTmutil,
	#superclass : #SuGenericUnixCommand,
	#category : 'ComputerWorld-Mac'
}

{ #category : #accessing }
CwTmutil class >> binary [
	^ 'tmutil'
]

{ #category : #accessing }
CwTmutil class >> disablingLocalSnapshots [
	^ self new
		template: self binary, ' disablelocal';
		asRoot;
		yourself.
]

{ #category : #accessing }
CwTmutil class >> enablingLocalSnapshots [
	^ self new
		template: self binary, ' enablelocal';
		asRoot;
		yourself.
]

{ #category : #accessing }
CwTmutil class >> excluding [
	"This command is 'sticky' in that is will persist if the file is moved. If you don't want this, you can pass -p, which we have not implemented (reference https://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html)"
	^ self new
		template: self binary, ' addexclusion {file}';
		asRoot;
		yourself.
]

{ #category : #accessing }
CwTmutil class >> listingBackups [
	^ self new
		template: self binary, ' listbackups';
		yourself.
]

{ #category : #accessing }
CwTmutil class >> showingDestinationIngo [
	^ self new
		template: self binary, ' destinationinfo';
		yourself.
]

{ #category : #accessing }
CwTmutil class >> startingBackup [
	^ self new
		template: self binary, ' startbackup';
		yourself.
]

{ #category : #accessing }
CwTmutil class >> stoppingBackup [
	^ self new
		template: self binary, ' stopbackup';
		yourself.
]
