Class {
	#name : #CwMac,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'instance creation' }
CwMac class >> current [
	^ self new
]

{ #category : #admin }
CwMac >> addSSH_KeysToKeychain [
	CwSSH addKeysToKeychain
]

{ #category : #accessing }
CwMac >> openFilesByProcess [
	SuGenericUnixCommand new
		template: 'sudo lsof -n +c 0 | cut -f1 -d'' '' | uniq -c | sort | tail';
		runInTerminal.
	"Adapted from https://superuser.com/a/1180084
		- `+c 0` prevents process name truncation
		- without sudo, it doesn't show all processes"
]

{ #category : #user }
CwMac >> saveScreenshotsAs: extensionString [
	"
	aString - e.g. 'jpeg' 'png' 'pdf'
	
	Adapted from https://www.cultofmac.com/154406/save-mac-os-x-screenshots-as-something-besides-png-os-x-tips/"
	Smalltalk tools shell
		waitForCommand: 'defaults write com.apple.screencapture type ', extensionString;
		waitForCommand: 'killall SystemUIServer'
]

{ #category : #accessing }
CwMac >> setUpForSmalltalk [
	Su_ln new
		link: FileLocator dynabookData parent / 'preferences';
		target: FileLocator preferences / 'pharo';
		run
]

{ #category : #admin }
CwMac >> viewKernelPanicLogs [
	"From https://www.macobserver.com/tmo/article/os-x-troubleshooting-kernel-panics"
	Smalltalk tools shell new command: 'open /Library/Logs/DiagnosticReports/*.panic'
]
