Class {
	#name : 'CwClamAV',
	#superclass : 'CwSoftware',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwClamAV class >> virusDatabaseFileURLs [
	"Auto download via 'freshclam' preferred because more efficient (only downloads diffs per https://www.clamav.net/documents/installing-clamav-on-unix-linux-macos-from-source)"
	^ self virusDatabaseFilenames collect: [ :n | 
			'https://database.clamav.net' asUrl / n ]
]

{ #category : 'as yet unclassified' }
CwClamAV class >> virusDatabaseFilenames [
	"From https://www.clamav.net/downloads"
	^ { 'main.cvd'. 'daily.cvd'. 'bytecode.cvd' }
]
