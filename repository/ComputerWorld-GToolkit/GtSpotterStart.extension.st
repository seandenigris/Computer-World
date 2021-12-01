Extension { #name : #GtSpotterStart }

{ #category : #'*ComputerWorld-GToolkit' }
GtSpotterStart >> cwGtSoftwareSpotterFor: aStep [
	<gtSearch>
	^ CwSoftwareCatalog
		gtSpotterOn: CwSoftwareCatalog uniqueInstance
		priority: 90
		for: aStep
]
