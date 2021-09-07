Class {
	#name : #CwHomebrewInstallCommand,
	#superclass : #Object,
	#instVars : [
		'admin',
		'project',
		'isCask'
	],
	#category : 'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrewInstallCommand class >> assert: anObject equalsCommand: commandString asUser: userString [
	<debuggerCompleteToSender>
	"See #template for rationale"
	self assert: anObject commandString equals: 'su ', userString, ' -c "', commandString, '"'
]

{ #category : #accessing }
CwHomebrewInstallCommand class >> example [
	<gtExample>
	^ self
		given: []
		when: [ 
			CwHomebrewInstallCommand new
				project: 'tesseract';
				yourself ]
		then: [ :it | self assert: it equalsCommand: 'brew install tesseract' asUser: CwHomebrew admin  ].
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
			self assert: it equalsCommand: 'brew cask install --no-quarantine --require-sha bettertouchtool' asUser: CwHomebrew admin ]
]

{ #category : #'as yet unclassified' }
CwHomebrewInstallCommand >> admin [
	^ CwHomebrew admin
]

{ #category : #accessing }
CwHomebrewInstallCommand >> admin: anObject [
	admin := anObject
]

{ #category : #accessing }
CwHomebrewInstallCommand >> commandString [
	"Reference: https://unix.stackexchange.com/a/1088/104011"

	| caskString optionalArguments result |
	self isCask
		ifTrue: [ 
			caskString := 'cask'.
			optionalArguments := '--no-quarantine --require-sha' ]
		ifFalse: [ caskString := optionalArguments := '' ].
	result := self template
		format:
			{(#project -> self project).
			(#admin -> self admin).
			(#optionalCask -> caskString).
			(#optionalArguments -> optionalArguments)} asDictionary.
	^ result withBlanksCondensed
]

{ #category : #'as yet unclassified' }
CwHomebrewInstallCommand >> execute [
	Smalltalk tools shell new runExternally: self commandString
]

{ #category : #accessing }
CwHomebrewInstallCommand >> gtCommandStringFor: aView [
	<gtView>
	
	^ aView text
		title: 'Command';
		text: [ self commandString ]
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
CwHomebrewInstallCommand >> template [
	"--require-sha: abort installation of cask if no checksum is defined
	--no-quarantine: Prevent Gatekeeper from enforcing its security restrictions on the Cask. This will let you run it straightaway.
	'Run as user' part adapted from *https://unix.stackexchange.com/a/1088/104011*"
	^ 'su {admin} -c "brew {optionalCask} install {optionalArguments} {project}"'
]
