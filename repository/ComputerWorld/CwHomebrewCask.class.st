Class {
	#name : #CwHomebrewCask,
	#superclass : #CwHomebrewInstallable,
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrewCask class >> pluralName [
	^ 'casks'
]

{ #category : #'as yet unclassified' }
CwHomebrewCask >> cwSoftwareName [
	^ self name capitalized
]

{ #category : #accessing }
CwHomebrewCask >> infoExtraFlags [
			
	^ ' --cask'
]

{ #category : #accessing }
CwHomebrewCask >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPutAll: ' cask'
]
