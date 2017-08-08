as yet unclassified
saveScreenshotsAs: aString
	"
	aString - e.g. 'jpeg' 'png' 'pdf'
	
	Adapted from https://www.cultofmac.com/154406/save-mac-os-x-screenshots-as-something-besides-png-os-x-tips/"
	Smalltalk tools shell
		waitForCommand: 'defaults write com.apple.screencapture type ', aString;
		waitForCommand: 'killall SystemUIServer'