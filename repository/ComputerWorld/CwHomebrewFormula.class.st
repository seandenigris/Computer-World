Class {
	#name : #CwHomebrewFormula,
	#superclass : #CwHomebrewInstallable,
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrewFormula class >> pluralName [
	^ 'formulae'
]

{ #category : #'as yet unclassified' }
CwHomebrewFormula >> cwSoftwareName [
	^ self name
]

{ #category : #accessing }
CwHomebrewFormula >> printOn: aStream [
	aStream
		nextPutAll: name;
		space;
		nextPutAll: ' formula'
]
