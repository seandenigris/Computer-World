"
There are two main choices for app installation target, each with different tradeoffs.

1. /Applications - After trying both, I ultimately settled on this because it fits better with Mac culture (see below). This method requires brewing as an administrator
2. ~/Applications - This seems attractive because you can brew from a non-admin account. However, in practice it's a PITA because too much of Mac assumes /Applications e.g. ""Open with…""

Whichever of the above you choose, you have to #makeUsrLocalWritable by either your normal user (for #2) or an administrator (for #1).
"
Class {
	#name : #CwHomebrew,
	#superclass : #Object,
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrew class >> binary [
	^ self rootFolder / 'bin' / 'brew'
]

{ #category : #accessing }
CwHomebrew class >> install [
	<script>
	
	"From https://brew.sh/
	
	Run #doctor immediately after and respond to output"

	| installCommand scriptSafeUnixCommand scriptTemplate script command |
	installCommand := '/bin/bash -c "$(curl -fsSL --ssl-reqd https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'.
	scriptSafeUnixCommand := installCommand copyReplaceAll: '"' with: '\"'.
	scriptTemplate := 'tell application "Terminal"
	do script "{installCommand}"
	activate
	end tell'.
	script := scriptTemplate format: { #installCommand -> scriptSafeUnixCommand } asDictionary.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.
]

{ #category : #accessing }
CwHomebrew class >> rootFolder [
	^ OSPlatform current isARM
		ifTrue: [ '/opt/homebrew' asFileReference ]
		ifFalse: [ '/usr/local' asFileReference ]
		
	"Reference: https://docs.brew.sh/Installation"
]

{ #category : #'as yet unclassified' }
CwHomebrew >> applicationFolder: folder [
	"Avoid permission errors when writing to /Applications (from https://github.com/caskroom/homebrew-cask/issues/27431#issuecomment-273127376)"
	
	self shouldBeImplemented.
	'export HOMEBREW_CASK_OPTS="--appdir=~/Applications"'
]

{ #category : #'as yet unclassified' }
CwHomebrew >> caskUpgrade [
	"
	- Must be run as administrator
	- Command from https://stackoverflow.com/questions/31968664/upgrade-all-the-casks-installed-via-homebrew-cask"

	Smalltalk tools shell runExternally: 'brew cask outdated | xargs brew cask reinstall'.
]

{ #category : #'as yet unclassified' }
CwHomebrew >> doctor [
	"#install outputs a message to do this"

	| exitCode |
	exitCode := Smalltalk tools shell waitForCommand: '/usr/local/bin/brew doctor'.
	exitCode = 0 ifFalse: [ self error: 'brew doctor failed' ].
]

{ #category : #accessing }
CwHomebrew >> exampleInstallTesseract [
	<gtExample>
	^ CwHomebrew new installCommand
		project: 'tesseract';
		yourself
]

{ #category : #accessing }
CwHomebrew >> installCommand [
	^ CwHomebrewInstallCommand new
]

{ #category : #'as yet unclassified' }
CwHomebrew >> makeUsrLocalWritable [
	"As of High Sierra, /usr/lib is no longer chown-able. The new procedure is:
	mkdir /usr/local/include
	sudo chown -R $(whoami) $(brew --prefix)/*
	
	From: https://github.com/Homebrew/brew/issues/3228"
	self shouldBeImplemented
]

{ #category : #accessing }
CwHomebrew >> searchFor: regexString [
	
	| tokenLineToObjects stringToObjects |
	tokenLineToObjects := [ :line :factory |
		| names |
		names := line splitOn: #isSeparator.
		names collect: [ :name |
			factory new
				name: name;
				yourself ] ].
				
	stringToObjects := [ :outStr |
		| lines factory |
		
		"We throw out empty lines to avoid a possible bug in splitting empty strings, which don't return an empty collection. Asked on Discord"
		lines := outStr lines reject: #isEmpty.
		
		lines flatCollect: [ :line |
			{ CwHomebrewFormula. CwHomebrewCask }
				detect: [ :cls | cls searchHeader = line ]
				ifFound: [ :cls | factory := cls. #() ]
				ifNone: [ tokenLineToObjects value: line value: factory ] ] ].
			
	^ '{binary} search {regex}' asSuCommand
		argumentAt: #binary put: self class binary;
		argumentAt: #regex put: regexString;
		outputDecoder: [ :outStr | stringToObjects value: outStr ];
		output.
]

{ #category : #accessing }
CwHomebrew >> untrack: anInstallable [
	| source targetFolder |
	source := self class rootFolder / 'Caskroom' / anInstallable name.
	targetFolder := (FileLocator home / 'Casks, Untracked') ensureCreateDirectory.
	source moveTo: targetFolder / anInstallable name.
	
	"Inspired by https://apple.stackexchange.com/q/435901"
]
