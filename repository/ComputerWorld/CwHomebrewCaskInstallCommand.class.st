Class {
	#name : #CwHomebrewCaskInstallCommand,
	#superclass : #Object,
	#instVars : [
		'admin',
		'project'
	],
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand class >> exampleCommandString [
	<sampleInstance>
	^ CwHomebrewCaskInstallCommand new
			"admin: 'admin'; can be set globally or per-command"
			project: 'bettertouchtool';
			commandString.
]

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand >> admin [
	^ CwHomebrew admin
]

{ #category : #accessing }
CwHomebrewCaskInstallCommand >> admin: anObject [
	admin := anObject
]

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand >> commandString [
	"Reference: https://unix.stackexchange.com/a/1088/104011"
	^ self template format: {
			#project -> self project.
			#admin -> self admin } asDictionary
]

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand >> execute [
	Smalltalk tools shell new runExternally: self commandString
]

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand >> gtInspectorIn: composite [
	<gtInspectorPresentationOrder: 10>
	
	composite text
		title: 'Command';
		display: [ self commandString ]
]

{ #category : #accessing }
CwHomebrewCaskInstallCommand >> project [
	^ project
]

{ #category : #accessing }
CwHomebrewCaskInstallCommand >> project: anObject [
	project := anObject
]

{ #category : #'as yet unclassified' }
CwHomebrewCaskInstallCommand >> template [
	"Reference: https://unix.stackexchange.com/a/1088/104011"
	^ 'su {admin} "brew cask install --require-sha {project}"'
]
