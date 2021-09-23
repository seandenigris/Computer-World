Class {
	#name : 'CwFirefox',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwFirefox class >> install [
	| dmgFile downloadCommand |
	downloadCommand := 'open ', 'https://www.mozilla.org/firefox/new/?scene=2'.
	downloadCommand asOssCommand run.
	self confirm: 'Click to continue when download is complete'.
	dmgFile := (FileLocator home / 'Downloads') filesMatching: 'Firefox *.dmg'.
	'/Volumes/Firefox/Firefox.app' asFileReference copyTo: '/Applications/Firefox.app' asFileReference
]
