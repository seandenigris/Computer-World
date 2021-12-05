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
CwSoftwareCatalog class >> gtSpotterOn: candidatesSource priority: aNumber for: aStep [
	"Helper to make available both from global and instance Spotters. See senders"

	^ aStep listProcessor
		priority: aNumber;
		title: 'Software';
		allCandidates: [ candidatesSource collection ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
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
CwSoftwareCatalog >> gtSpotterFor: aStep [
	<gtSearch>
	^ self class
		gtSpotterOn: self
		priority: 5 
		for: aStep
]

{ #category : #accessing }
CwSoftwareCatalog >> gtSpotterNewCatalogFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Software';
		priority: 50;
		itemName: [ :input | 'Catalog new software: ', input ];
		previewObject: [ :input | CwSoftware named: input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self collection anySatisfy: [ :e | 
					e name = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :newName :spotterStep | self collection add: (CwSoftware named: newName) ]
]

{ #category : #accessing }
CwSoftwareCatalog >> gtViewCollectionOn: aView [
	<gtView>
	
	^ aView list
		title: 'Software' translated;
		priority: 5;
		items: [ self collection ];
		yourself.
]