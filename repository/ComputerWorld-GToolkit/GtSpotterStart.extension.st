Extension { #name : #GtSpotterStart }

{ #category : #'*ComputerWorld-GToolkit' }
GtSpotterStart >> cwGtSearchMacAppFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		title: 'Mac Application';
		priority: 50;
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			(input endsWith: '.app')
				ifTrue: [ { CwMacApplication fromBundle: input asFileReference } asAsyncStream ]
				ifFalse: [ {} asAsyncStream ] ]
]

{ #category : #'*ComputerWorld-GToolkit' }
GtSpotterStart >> cwGtSoftwareSpotterFor: aStep [
	<gtSearch>
	^ CwSoftwareCatalog
		itemsSearchOn: CwSoftwareCatalog uniqueInstance
		priority: 90
		for: aStep
]
