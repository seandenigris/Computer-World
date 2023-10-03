"
This domain evokes that of library works, where there might be a series of sub-works, editions of a single work, and copies of works. Here we have software as colloquially thought of e.g. ""oh, 1Password, does that work on Android? iOS? Windows?"". Then there is a version that runs on (a) particular OS(es). Then there is the running instance. The need to distinguish ""software"" from platform-specific ""version"" is uncertain, but it seems clear to distinguish them from ""running instance"". Maybe start there and play. The minimum to connect the two would be one of either: 1) bundle name/location or 2) CwMacApplication subclass

Keep track of preferences
Maybe:
	software usesPreferenceFiles: { '~/Library/Preferences/com.red-sweater.FastScripts.plist'.
'~/Library/Preferences/com.red-sweater.FastScripts.plist.JaqYaCy' }.
"
Class {
	#name : #CwSoftware,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'name',
		'urlDownloadsOnOpen',
		'timePageOpened',
		'downloadingFile',
		'webpageUrl',
		'homebrewName',
		'downloadUrl',
		'installers'
	],
	#classVars : [
		'DB'
	],
	#category : #'ComputerWorld-Core'
}

{ #category : #'as yet unclassified' }
CwSoftware class >> assertSha: algorithmNumber for: file equals: aString [
	"This should obviously be better integrated i.e. on the instance side, etc."
	
	CwShaSum assertSha: algorithmNumber for: file equals: aString
]

{ #category : #'as yet unclassified' }
CwSoftware class >> assertShaFor: file equals: aString [
	"This should obviously be better integrated i.e. on the instance side, etc."
	
	| commandTemplate tmpOutputFile command computedSha |
	commandTemplate := 'shasum "{1}" > "{2}"'.
	tmpOutputFile := ('sha', file fullName asValidSelector, '.txt') asFileReference.
	command := commandTemplate format: { file fullName. tmpOutputFile fullName }.
	Smalltalk tools shell waitForCommand: command.
	computedSha := tmpOutputFile contents copyUpTo: Character space.
	self assert: computedSha = aString.
	
]

{ #category : #accessing }
CwSoftware class >> db [

	^ DB ifNil: [ DB := SortedCollection sortBlock: #name ascending ]
]

{ #category : #accessing }
CwSoftware class >> db: anObject [

	DB := anObject
]

{ #category : #examples }
CwSoftware class >> exampleAnki [
	^ self
		given: []
		when: [ 
			(self named: 'Anki')
				homebrewName: 'anki';
				downloadUrl: 'https://github.com/ankitects/anki/releases/download/' asUrl;
				yourself ]	
		then: [ :r | ]
]

{ #category : #examples }
CwSoftware class >> exampleZoom [
	^ self
		given: []
		when: [ 
			(self named: 'Zoom')
				homebrewName: 'zoom';
				downloadUrl: 'https://cdn.zoom.us/prod/' asUrl;
				webpage: 'https://www.zoom.us' asUrl;
				yourself ]	
		then: [ :r | ]
]

{ #category : #accessing }
CwSoftware class >> gtDBFor: aView [
	<gtView>
	<gtClassView>
	self db ifEmpty: [ ^ aView empty ].
	^ aView forward 
		title: 'DB';
		priority: 50;
		object: [ self db ];
		view: #gtItemsFor:
]

{ #category : #'instance creation' }
CwSoftware class >> named: aString [ 

	^ self new setName: aString.
]

{ #category : #persistence }
CwSoftware class >> restoreFrom: anObject [

	DB := anObject.
]

{ #category : #persistence }
CwSoftware class >> spData [

	^ DB.
]

{ #category : #accessing }
CwSoftware >> <= rhs [
	^ self name <= rhs name
]

{ #category : #accessing }
CwSoftware >> addToCatalog [
	CwSoftwareCatalog uniqueInstance collection add: self
]

{ #category : #Morphic }
CwSoftware >> asMorph [

	^ CwSoftwareMorph on: self.
]

{ #category : #accessing }
CwSoftware >> closeTheBrowserWindow [

	CwSafari reference closeWindow: 1. 
]

{ #category : #downloading }
CwSoftware >> download [

	| commandTemplate |
	self downloadPath ensureCreateFile.
	commandTemplate := 'cd "{1}" > /dev/null ; curl -O "{2}"'.
	Smalltalk tools shell new run: (commandTemplate format: { self downloadPath. downloadUrl }).
]

{ #category : #private }
CwSoftware >> downloadByOpening: aUrl [

	urlDownloadsOnOpen := aUrl.
	timePageOpened := DateAndTime now.
	self openInBrowser: aUrl.
	self waitForFileToBeginDownloading.
	self closeTheBrowserWindow.
	self waitForFileToFinishDownloading.
	self waitForFileToUnzip.
	self moveFileToApplicationsFolder.
]

{ #category : #downloading }
CwSoftware >> downloadPath [

	^ FileLocator home / 'Documents/Squeak Library/Software' / self fullName / 'Download'.
]

{ #category : #downloading }
CwSoftware >> downloadUrl [

	^ downloadUrl.
]

{ #category : #downloading }
CwSoftware >> downloadUrl: aUrlOrString [ 

	downloadUrl := aUrlOrString asUrl.
]

{ #category : #accessing }
CwSoftware >> fullName [

	^ self name.
]

{ #category : #'private-testing' }
CwSoftware >> hasBeenDownloaded [

	^ self downloadPath hasChildren.
]

{ #category : #accessing }
CwSoftware >> homebrewFormulaUrl [
	^ ('https://formulae.brew.sh/cask/', self homebrewName) asUrl
]

{ #category : #accessing }
CwSoftware >> homebrewInstallCommand [
	| result |
	result := CwHomebrew new installCommand
		project: self;
		ensureDownloadedFrom: self downloadUrl;
		yourself.
		
	self name first isUppercase ifTrue: [ result isCask: true ].
	
	^ result
]

{ #category : #accessing }
CwSoftware >> homebrewName [
	^ homebrewName
]

{ #category : #accessing }
CwSoftware >> homebrewName: aString [
	"aString - make uppercase if it's a cask"

	homebrewName := aString
]

{ #category : #accessing }
CwSoftware >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #installing }
CwSoftware >> install [

	self hasBeenDownloaded ifFalse: [ self download ].
	self unzipDownloadedFile.
]

{ #category : #accessing }
CwSoftware >> installers [

	^ installers ifNil: [ installers := Bag new ]
]

{ #category : #accessing }
CwSoftware >> installers: anObject [

	installers := anObject
]

{ #category : #private }
CwSoftware >> moveFileToApplicationsFolder [

	| commandTemplate sourceFolder sourceFile |
	sourceFolder := FileLocator home / 'Downloads'.
	sourceFile := sourceFolder / '1Password.app'.
	commandTemplate := 'mv "{1}" /Applications'.
	"OSProcess command: (commandTemplate format: { sourceFile fullName })."
]

{ #category : #accessing }
CwSoftware >> name [
	^ name ifNil: [ name := '' ].
]

{ #category : #accessing }
CwSoftware >> nameForAlphabetization [
	
	^ self name asUppercase
]

{ #category : #private }
CwSoftware >> openInBrowser: aUrl [

	ExternalWebBrowser openOnUrl: aUrl.
]

{ #category : #printing }
CwSoftware >> printOn: aStream [

	aStream nextPutAll: self fullName. 
]

{ #category : #private }
CwSoftware >> setName: aString [ 

	name := aString.
]

{ #category : #private }
CwSoftware >> unzipDownloadedFile [

	ZipArchive new
		readFrom: ((FileDirectory on: self downloadPath) matchingEntries: '*.zip') first fullName;
		extractAllTo: (FileDirectory on: self downloadPath).
]

{ #category : #private }
CwSoftware >> waitForFileToBeginDownloading [

	| downloadDirectory wasCreatedAfterPageOpened |
	downloadDirectory := FileLocator home / 'Downloads'.
	[ downloadingFile isNil ] whileTrue: [
		downloadingFile := downloadDirectory entries
			detect: [ :f | 
				(f wasCreatedAfter: timePageOpened) and: [ f isDownloading ] ]
			ifNone: [ nil ] ].
	
	
]

{ #category : #private }
CwSoftware >> waitForFileToFinishDownloading [

	[ downloadingFile isFinishedDownloading ] whileFalse.
]

{ #category : #private }
CwSoftware >> waitForFileToUnzip [

	| downloadsFolder |
	downloadsFolder := FileLocator home / 'Downloads'.
	[ downloadsFolder includesKey: '1Password.app' ] whileFalse. 
]

{ #category : #accessing }
CwSoftware >> webpage [

	^ webpageUrl.
]

{ #category : #accessing }
CwSoftware >> webpage: aUrlOrString [ 

	webpageUrl := aUrlOrString asUrl.
]
