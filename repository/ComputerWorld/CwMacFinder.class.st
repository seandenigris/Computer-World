Class {
	#name : #CwMacFinder,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwMacFinder class >> bundleBasename [
	^ 'Finder.app'
]

{ #category : #accessing }
CwMacFinder class >> bundleParent [
	^ '/System/Library/CoreServices/' asFileReference
]

{ #category : #'instance creation' }
CwMacFinder class >> uniqueInstance [
	<gtExample>
	^ self new
]

{ #category : #'system settings' }
CwMacFinder >> hideHiddenFiles [

	self showHiddenFiles: false
]

{ #category : #shell }
CwMacFinder >> restart [
	self run: 'killall Finder'
]

{ #category : #shell }
CwMacFinder >> restartAfterRunning: commandString [

	self run: commandString.
	self restart
]

{ #category : #shell }
CwMacFinder >> run: commandString [

	LibC system: commandString
]

{ #category : #'system settings' }
CwMacFinder >> showHiddenFiles [

	self showHiddenFiles: true
]

{ #category : #'system settings' }
CwMacFinder >> showHiddenFiles: aBoolean [
	
	self restartAfterRunning: 'defaults write com.apple.finder AppleShowAllFiles -bool ', aBoolean asCwPlistString
]
