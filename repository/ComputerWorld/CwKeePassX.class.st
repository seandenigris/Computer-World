Class {
	#name : 'CwKeePassX',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'documentation' }
CwKeePassX class >> currentVersion [
	^ '2.0.3'
]

{ #category : 'as yet unclassified' }
CwKeePassX class >> download [

	ZnClient new
		url: self downloadSourceFolder / self downloadFilename;
		downloadTo: FileLocator home / 'Downloads'.
]

{ #category : 'as yet unclassified' }
CwKeePassX class >> download: url [

	ZnClient new
		url: url;
		downloadTo: FileLocator home / 'Downloads'.
]

{ #category : 'as yet unclassified' }
CwKeePassX class >> downloadFilename [
	^ 'KeePassX-', self currentVersion, '.dmg'
]

{ #category : 'as yet unclassified' }
CwKeePassX class >> downloadSourceFolder [

	^ 'https://www.keepassx.org/releases' asUrl / self currentVersion
]

{ #category : 'documentation' }
CwKeePassX class >> verifyDownload [
	<script>
	
	| keyFilename keyFileUrl |
	keyFilename := self downloadFilename, '.sig'.
	keyFileUrl := self downloadSourceFolder / keyFilename.
	self download: keyFileUrl.
	CwGpgTools new
		verify: FileLocator home / 'Downloads' / self downloadFilename
		with: FileLocator home / 'Downloads' / keyFilename
]
