Class {
	#name : 'CwKeePassXC',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'documentation' }
CwKeePassXC class >> currentVersion [
	^ '2.7.6'
]

{ #category : 'accessing' }
CwKeePassXC class >> download [
	| installer |
	installer := self download: self downloadFilename, '.dmg'.
	self verifyDownload: installer.
	^ installer
]

{ #category : 'accessing' }
CwKeePassXC class >> download: filename [

	| target |
	target := Tempfile withSuffix: filename.
	ZnClient new
		url: self downloadSourceFolder / filename;
		downloadTo: target.
	^ target
]

{ #category : 'accessing' }
CwKeePassXC class >> downloadFilename [
	^ 'KeePassXC-', self currentVersion, '-arm64'
]

{ #category : 'accessing' }
CwKeePassXC class >> downloadSourceFolder [

	^ 'https://github.com/keepassxreboot/keepassxc/releases/download' asUrl / self currentVersion
]

{ #category : 'documentation' }
CwKeePassXC class >> verifyDownload: aFileReference [
	<script>
	
	| signature |
	signature := self download: self downloadFilename, '.sig'.
	CwGpgTools new
		verify: aFileReference
		with: signature
]
