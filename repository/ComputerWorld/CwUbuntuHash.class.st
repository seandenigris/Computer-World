"
### Usage example:
```
self verify: 'ubuntu-12.04.4-desktop-amd64.iso' asFileReference.
```
"
Class {
	#name : #CwUbuntuHash,
	#superclass : #Object,
	#instVars : [
		'filename',
		'md5'
	],
	#category : 'ComputerWorld-Support'
}

{ #category : #accessing }
CwUbuntuHash class >> all [

	| soup hashRows |
	soup := Soup fromUrl: self secureUrl.
	hashRows := soup findAllTags: [ :e |
		'line862'.
		e name = 'tr' and: [ [ e td p hasClass: 'line862' ] on: Error do: [ false ] ] ].
	^ hashRows collect: [ :row | | cells |
		cells := row findAllChildTags: 'td'.
		CwUbuntuHash
			filename: cells second text trimBoth
			md5: cells first text trimBoth. ]
]

{ #category : #'instance creation' }
CwUbuntuHash class >> filename: filename md5: hashString [ 

	^ self new
		filename: filename;
		md5: hashString;
		yourself.
]

{ #category : #accessing }
CwUbuntuHash class >> forFileNamed: basename [

	^ self all 
		detect: [ :e | e filename = basename ]
		ifNone: [ self error: 'Ubuntu does not list a hash for ', basename, ' at ', self secureUrl asString ].
]

{ #category : #actions }
CwUbuntuHash class >> verify: file [
	| sumsFile filenameTokens version versionTokens majorMinor releaseUrl furtherInstructions |
	filenameTokens := file basenameWithoutExtension findTokens: '-'.
	self assert: filenameTokens first = 'ubuntu'.
	version := filenameTokens second.
	versionTokens := version findTokens: '.'.
	majorMinor := (versionTokens first: 2) joinUsing: $..
	"sumsUrl := self secureUrl, 'SHA256SUMS'."
	releaseUrl := 'http://releases.ubuntu.com/' asUrl / majorMinor.
	Smalltalk tools webBrowser open: releaseUrl.
	furtherInstructions := 'Instead of hosting the checksums on an encrypted page, you have to download them and check them against Ubuntu''s GPG keys. From https://help.ubuntu.com/community/VerifyIsoHowto:
gpg --verify SHA256SUMS.gpg SHA256SUMS
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys #({keyBinaryShort},...)
gpg --verify SHA256SUMS.gpg SHA256SUMS'.
	Smalltalk tools workspace openContents: furtherInstructions.
	self notify: 'The process got more complicated, and I don''t feel like updating at the moment.'.
	sumsFile := FileLocator home / 'Downloads' / 'SHA256SUMS'.
	(file verifySha256Equals: sumsFile).
	UIManager inform: file basename, ' verified'.
]

{ #category : #accessing }
CwUbuntuHash >> filename [
	^ filename
]

{ #category : #private }
CwUbuntuHash >> filename: aString [ 

	filename := aString.
]

{ #category : #accessing }
CwUbuntuHash >> md5 [
	^ md5
]

{ #category : #private }
CwUbuntuHash >> md5: aString [ 

	md5 := aString.
]

{ #category : #printing }
CwUbuntuHash >> printOn: aStream [

	aStream
		nextPutAll: 'md5(';
		nextPutAll: filename;
		nextPutAll: ') = ';
		nextPutAll: md5.
]

{ #category : #accessing }
CwUbuntuHash >> secureUrl [
	^ 'http://releases.ubuntu.com/14.04/SHA256SUMS' asUrl.
]

{ #category : #actions }
CwUbuntuHash >> verify: file [

	"sumsUrl := self secureUrl, 'SHA256SUMS'."
	| sumsFile |
	sumsFile := FileLocator home / 'Downloads' / 'SHA256SUMS'.
	(file verifySha256Equals: sumsFile).
	UIManager inform: file basename, ' verified'.
]

{ #category : #accessing }
CwUbuntuHash >> version [
	^ self filename copyFrom: 8 to: 12
]
