Class {
	#name : #CwHomebrewInstallable,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ComputerWorld-Homebrew'
}

{ #category : #accessing }
CwHomebrewInstallable class >> pluralName [
	self subclassResponsibility
]

{ #category : #accessing }
CwHomebrewInstallable class >> searchHeader [
	^ '==> ', self pluralName capitalized
]

{ #category : #accessing }
CwHomebrewInstallable >> addToCwSoftwareCatalog [
	^ CwSoftwareCatalog uniqueInstance collection add: self asCwSoftware
]

{ #category : #accessing }
CwHomebrewInstallable >> asCwSoftware [
	^ (CwSoftware named: self cwSoftwareName)
		homebrewName: self name;
		yourself
]

{ #category : #accessing }
CwHomebrewInstallable >> info [
			
	^ '{binary} info --json=v2 {extraFlags} {name}' asSuCommand
		argumentAt: #binary put: CwHomebrew binary;
		argumentAt: #extraFlags put: self infoExtraFlags;
		argumentAt: #name put: self name;
		outputDecoder: [ :outStr | 
			| json |
			json := NeoJSONReader fromString: outStr.
			(json at: self class pluralName) first  ];
		output.
]

{ #category : #accessing }
CwHomebrewInstallable >> infoExtraFlags [
		^ ''
]

{ #category : #accessing }
CwHomebrewInstallable >> name [

	^ name
]

{ #category : #accessing }
CwHomebrewInstallable >> name: anObject [

	name := anObject
]
