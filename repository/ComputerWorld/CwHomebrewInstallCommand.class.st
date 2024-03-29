Class {
	#name : #CwHomebrewInstallCommand,
	#superclass : #SuGenericUnixCommand,
	#instVars : [
		'admin',
		'project',
		'isCask',
		'downloadRootUrl'
	],
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrewInstallCommand class >> example [
	<gtExample>
	^ self
		given: []
		when: [ 
			CwHomebrewInstallCommand new
				project: 'tesseract';
				yourself ]
		then: [ :it | self assert: it basicCommandString equals: 'brew install tesseract' ].
]

{ #category : #accessing }
CwHomebrewInstallCommand class >> exampleCask [
	<gtExample>
	^ self
		given: []
		when: [ 
			CwHomebrewInstallCommand new
			project: 'bettertouchtool';
			isCask: true;
			yourself ]
		then: [ :it |
			self assert: it basicCommandString equals: 'brew install --cask --require-sha bettertouchtool' ]
]

{ #category : #accessing }
CwHomebrewInstallCommand class >> exampleCaskUrlMismatch [
	<gtExample>
	^ self
		given: []
		when: [ 
			CwSoftware exampleAnki homebrewInstallCommand ]
		then: [ :it |
			self assert: it basicCommandString equals: 'brew install --cask --require-sha anki' ]
]

{ #category : #accessing }
CwHomebrewInstallCommand >> argumentSource [

	| caskFlags |
	caskFlags := self isCask 
		ifTrue: [ ' --cask --require-sha ' ] "maybe automatically --no-quarantine is too aggressive/risky"
		ifFalse: [ '' ].
	^ {
		#caskFlags -> caskFlags.
		#project -> self project homebrewName } asDictionary
]

{ #category : #accessing }
CwHomebrewInstallCommand >> downloadRootUrl [
	^ downloadRootUrl
]

{ #category : #accessing }
CwHomebrewInstallCommand >> ensureDownloadedFrom: aUrl [
	downloadRootUrl := aUrl
]

{ #category : #accessing }
CwHomebrewInstallCommand >> execute [
	self verifyUrl.
	super execute
]

{ #category : #accessing }
CwHomebrewInstallCommand >> initialize [
	super initialize.
	template := 'brew install {caskFlags} {project}'.
	self asAdministrator.
]

{ #category : #accessing }
CwHomebrewInstallCommand >> isCask [
	^ isCask ifNil: [ false ]
]

{ #category : #accessing }
CwHomebrewInstallCommand >> isCask: aBoolean [
	isCask := aBoolean
]

{ #category : #accessing }
CwHomebrewInstallCommand >> project [
	^ project
]

{ #category : #accessing }
CwHomebrewInstallCommand >> project: anObject [
	project := anObject
]

{ #category : #accessing }
CwHomebrewInstallCommand >> verifyUrl [
	| formulaUrl formula |
	formulaUrl := 'https://formulae.brew.sh/api/cask' asUrl / (self project, '.json').
	formula := STONJSON fromString: formulaUrl retrieveContents.
	self assert: ((formula at: #url) beginsWith: self downloadRootUrl asString)
]
