Class {
	#name : #CwMac,
	#superclass : #Object,
	#category : 'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwMac >> saveScreenshotsAs: aString [
	"
	aString - e.g. 'jpeg' 'png' 'pdf'
	
	Adapted from https://www.cultofmac.com/154406/save-mac-os-x-screenshots-as-something-besides-png-os-x-tips/"
	Smalltalk tools shell
		waitForCommand: 'defaults write com.apple.screencapture type ', aString;
		waitForCommand: 'killall SystemUIServer'
]

{ #category : #'as yet unclassified' }
CwMac >> viewKernelPanicLogs [
	"From https://www.macobserver.com/tmo/article/os-x-troubleshooting-kernel-panics"
	Smalltalk tools shell command: 'open /Library/Logs/DiagnosticReports/*.panic'
]
