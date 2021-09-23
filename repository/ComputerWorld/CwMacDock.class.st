Class {
	#name : 'CwMacDock',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac'
}

{ #category : 'as yet unclassified' }
CwMacDock >> add: appBundle [
	| commandTemplate command |
	commandTemplate := '/usr/bin/defaults write com.apple.dock persistent-apps -array-add ''<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>{appBundle}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'''.
	command := commandTemplate format: {(#appBundle -> appBundle fullName)} asDictionary.
	self restartAfterRunning: command
]

{ #category : 'as yet unclassified' }
CwMacDock >> autoHideDelay: aNumber [
	| commandTemplate command |
	commandTemplate := 'defaults write com.apple.dock autohide-time-modifier -float {delay}'.
	command := commandTemplate format: {(#delay -> aNumber asString)} asDictionary.
	self restartAfterRunning: command
]

{ #category : 'as yet unclassified' }
CwMacDock >> autoHideViaDefaults [
	"We'll use Applescript instead, which doesn't require 'killing' the Dock"

	| commandTemplate command |
	commandTemplate := '/usr/bin/defaults write com.apple.Dock autohide -bool {flag}'. "Didn't work w/o bool flag; changed type to string"
	command := commandTemplate format: { #flag -> 'yes' } asDictionary.
	self restartAfterRunning: command
]

{ #category : 'as yet unclassified' }
CwMacDock >> magnification: factor [
	"From https://www.tekrevue.com/tip/the-complete-guide-to-customizing-mac-os-xs-dock-with-terminal/"
	"Default = 128; Usual largest = 256"

	| largeSize command |
	largeSize := factor * 64.
	command := 'defaults write com.apple.dock largesize -float ' , largeSize asString.
	self restartAfterRunning: command
]

{ #category : 'as yet unclassified' }
CwMacDock >> restart [
	self run: 'killall Dock'
]

{ #category : 'as yet unclassified' }
CwMacDock >> restartAfterRunning: commandString [

	self run: commandString.
	self restart
]

{ #category : 'as yet unclassified' }
CwMacDock >> run: commandString [

	LibC system: commandString
]

{ #category : 'as yet unclassified' }
CwMacDock >> toggleAutoHide [
	"From https://discussions.apple.com/message/21990325#message21990325"

	| command |
	command := 'osascript -e ''tell application "System Events" to set autohide of dock preferences to not (autohide of dock preferences)'''.
	self run: command
]
