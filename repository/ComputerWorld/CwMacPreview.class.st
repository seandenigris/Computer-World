Class {
	#name : #CwMacPreview,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwMacPreview class >> bundleBasename [
	^ 'Preview.app'
]

{ #category : #accessing }
CwMacPreview >> goToPage: anInteger [

	Applescript new
		template: 'tell application "Preview" to activate
tell application "System Events" to tell process "Preview" to click menu item "Go to Page…" of menu "Go" of menu bar 1
tell application "System Events" to keystroke "{pageNumber}"
tell application "System Events" to key code 36';
		argumentAt: #pageNumber put: anInteger;
		run.
		
	"Adapted from https://apple.stackexchange.com/questions/233945/opening-a-specific-page-on-mac-preview-from-terminal"
]
