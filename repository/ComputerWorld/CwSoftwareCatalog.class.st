Class {
	#name : #CwSoftwareCatalog,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'ComputerWorld-Core'
}

{ #category : #accessing }
CwSoftwareCatalog class >> itemsSearchOn: candidatesSource priority: aNumber for: aSearch [
	"Helper to make available both from global and instance Spotters. See senders"

	^ aSearch list
		priority: aNumber;
		title: 'Software';
		items: [ candidatesSource collection ];
		matchSubstrings;
		itemName: #name
]

{ #category : #accessing }
CwSoftwareCatalog class >> restoreFrom: anObject [

	UniqueInstance := anObject
]

{ #category : #accessing }
CwSoftwareCatalog class >> spData [
	^ UniqueInstance
]

{ #category : #accessing }
CwSoftwareCatalog class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
CwSoftwareCatalog >> collection [
	^ collection ifNil: [ collection := SortedCollection sortBlock: #name ascending ]
]

{ #category : #accessing }
CwSoftwareCatalog >> collection: aCollection [
	collection := aCollection
]

{ #category : #accessing }
CwSoftwareCatalog >> collectionSearchFor: aStep [
	<gtSearch>
	^ self class
		itemsSearchOn: self
		priority: 5 
		for: aStep
]

{ #category : #accessing }
CwSoftwareCatalog >> collectionSearchNewSoftwareFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'New Software';
		priority: 50;
		itemName: [ :result | '+ ' , result gtDisplayText ];
		search: [ :context | { CwSoftware named: context searchQuery trimmed } ];
		send: [ :result | self collection add: result ]
]

{ #category : #accessing }
CwSoftwareCatalog >> collectionViewOn: aView [
	<gtView>
	
	^ aView list
		title: 'Software' translated;
		priority: 5;
		items: [ self collection ];
		actionUpdateButton;
		yourself.
]
