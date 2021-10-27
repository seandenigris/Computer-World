"
Keep track of preferences
Maybe:
	software usesPreferenceFiles: { '~/Library/Preferences/com.red-sweater.FastScripts.plist'.
'~/Library/Preferences/com.red-sweater.FastScripts.plist.JaqYaCy' }.
"
Class {
	#name : #CwSoftware,
	#superclass : #Object,
	#instVars : [
		'name',
		'urlDownloadsOnOpen',
		'timePageOpened',
		'downloadingFile',
		'webpageUrl',
		'downloadUrl'
	],
	#category : 'ComputerWorld-Core'
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

{ #category : #'instance creation' }
CwSoftware class >> named: aString [ 

	^ self new setName: aString.
]

{ #category : #private }
CwSoftware >> = rhs [

	^ self fullName = rhs fullName.
]

{ #category : #Morphic }
CwSoftware >> asMorph [

	^ CwSoftwareMorph on: self.
]

{ #category : #downloading }
CwSoftware >> canBeDownloadedAt: aUrlOrString [ 

	downloadUrl := aUrlOrString asUrl.
]

{ #category : #'as yet unclassified' }
CwSoftware >> closeTheBrowserWindow [

	Safari reference closeWindow: 1. 
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

{ #category : #accessing }
CwSoftware >> fullName [

	^ name.
]

{ #category : #'private-testing' }
CwSoftware >> hasBeenDownloaded [

	^ self downloadPath hasChildren.
]

{ #category : #private }
CwSoftware >> hash [

	^ self fullName hash.
]

{ #category : #installing }
CwSoftware >> install [

	self hasBeenDownloaded ifFalse: [ self download ].
	self unzipDownloadedFile.
]

{ #category : #private }
CwSoftware >> moveFileToApplicationsFolder [

	| commandTemplate sourceFolder sourceFile |
	sourceFolder := FileLocator home / 'Downloads'.
	sourceFile := sourceFolder / '1Password.app'.
	commandTemplate := 'mv "{1}" /Applications'.
	"OSProcess command: (commandTemplate format: { sourceFile fullName })."
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
	downloadDirectory := FileDirectory on: '/Users/god/Downloads/'.
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
	downloadsFolder := (FileDirectory on: '/Users/god/Downloads').
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
