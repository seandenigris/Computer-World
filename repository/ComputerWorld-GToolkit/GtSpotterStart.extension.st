Extension { #name : #GtSpotterStart }

{ #category : #'*ComputerWorld-GToolkit' }
GtSpotterStart >> cwGtSoftwareSpotterFor: aStep [
	<gtSearch>
	^ CwSoftwareCatalog
		itemsSearchOn: CwSoftwareCatalog uniqueInstance
		priority: 90
		for: aStep
]
