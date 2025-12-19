"
1. Download from the website. See {{gtMethod:CwGpgTools class>>#url}}.
2. Check the checksum (also on the website) with {{gtMethod:AbstractFileReference>>#sha256}}.
"
Class {
	#name : 'CwGpgTools',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'documentation' }
CwGpgTools class >> download [

	UIManager inform: 'No permalink... download from project page...'.
	self url open.
]

{ #category : 'documentation' }
CwGpgTools class >> shaLatestVersion [

	| downloadPageSource shaLine matcher |
	downloadPageSource := 'https://gpgtools.org/gpgsuite.html' asUrl retrieveContents.
	shaLine := downloadPageSource lines detect: [ :e | e trimLeft beginsWith: '<p>SHA-1:' ].
	matcher := RxMatcher forString: '<p>SHA-1\: (\w+)</p>'.
	matcher search: shaLine trimBoth.
	^ matcher subexpression: 2
]

{ #category : 'documentation' }
CwGpgTools class >> url [

	^ 'https://gpgtools.org/' asUrl.
]

{ #category : 'documentation' }
CwGpgTools class >> verifyDownload [

	| installer |
	installer := (FileLocator home / 'Downloads') files detect: [ :e | e basename matchesRegex: 'GPG Suite - .*\.dmg' ].
	CwSoftware assertShaFor: installer equals: self shaLatestVersion.
]

{ #category : 'as yet unclassified' }
CwGpgTools >> importKey: hexString [
	"Adapted from https://www.torproject.org/docs/verifying-signatures.html.en"

	| commandTemplate command exitCode |
	commandTemplate := 'gpg --keyserver x-hkp://pool.sks-keyservers.net --recv-keys {1}'.
	command := commandTemplate format: { hexString }.
	exitCode := Smalltalk tools shell waitForCommand: command.
	exitCode = 0 ifFalse: [ self error: 'Couldn''t import gpg key' ].
]

{ #category : 'as yet unclassified' }
CwGpgTools >> verify: file with: key [
	"Adapted from https://www.torproject.org/docs/verifying-signatures.html.en"

	| commandTemplate command exitCode |
	commandTemplate := '/usr/local/bin/gpg --verify "{1}" "{2}"'.
	command := commandTemplate format: { key fullName. file fullName }.
	exitCode := Smalltalk tools shell waitForCommand: command.
	exitCode = 0
		ifTrue: [ self inform: file base, ' validated!' ]
		ifFalse: [ self error: file base, ' failed validation' ].
]
