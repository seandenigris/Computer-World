Class {
	#name : 'CwTravisCI',
	#superclass : 'CwSoftware',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwTravisCI class >> browseTemplateDoc [
	<script>
	
	'https://github.com/hpi-swa/smalltalkCI#templates' asZnUrl open
]

{ #category : 'as yet unclassified' }
CwTravisCI >> addBadgeToReadmeIn: repositoryFolder for: projectName by: user [ 
	"It was tempting to retrieve the project name and user from the command line via `git remote get-url origin`, but at the moment doesn't seem worth the effort or dependency on a shell-support library"
	| reference originalContents |
	reference := repositoryFolder / 'README.md'.
	originalContents := reference ensureCreateFile contents.
	reference writeStreamDo: [ :str |
		str
			nextPutAll: (self badgeMarkupForProject: projectName byUser: user);
			lf;
			nextPutAll: originalContents ]
]

{ #category : 'as yet unclassified' }
CwTravisCI >> addStonFileFor: repositoryFolder [

	| contentsTemplate reference contents baselineName |
	reference := repositoryFolder / '.smalltalk.ston'.
	reference exists ifTrue: [ ^ reference ].
	
	baselineName := repositoryFolder base select: [ :c | c isAlphaNumeric ].
	contentsTemplate := 'SmalltalkCISpec \{
  #loading : [
    SCIMetacelloLoadSpec \{
      #baseline : ''{baselineName}'',
      #directory : ''repository'',
      #platforms : [ #pharo ]
    }
  ]
}' withUnixLineEndings.
	contents := contentsTemplate format: { #baselineName -> baselineName } asDictionary.
	reference ensureCreateFile writeStreamDo: [ :s | s nextPutAll: contents ]

]

{ #category : 'as yet unclassified' }
CwTravisCI >> addYmlFileFor: repositoryFolder [

	| reference contents |
	reference := repositoryFolder / '.travis.yml'.
	reference exists ifTrue: [ ^ reference ].
	contents := 'language: smalltalk
sudo: false

# Select operating system(s)
os:
  #- linux
  - osx

# Select compatible Smalltalk image(s)
smalltalk:
  - Pharo-6.0
  - Pharo-5.0' withUnixLineEndings.
	reference ensureCreateFile writeStreamDo: [ :s | s nextPutAll: contents ]

]

{ #category : 'as yet unclassified' }
CwTravisCI >> badgeMarkupForProject: project byUser: user [

	| template |
	template := '[![Build Status](https://travis-ci.org/{user}/{project}.png?branch=master)](https://travis-ci.org/{user}/{project})'.
	^ template format: { 
			#project -> project.
			#user -> user } asDictionary
]

{ #category : 'as yet unclassified' }
CwTravisCI >> setUp: folder [
	folder exists ifFalse: [ self error: 'No repo at ', folder fullName ].
	self
		addStonFileFor: folder;
		addYmlFileFor: folder
]
