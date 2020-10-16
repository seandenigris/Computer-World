Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld-GToolkit' }
AbstractFileReference >> gtCwMacApplicationFor: aView inContext: aContext [
	<gtView>
	self extension = 'app' ifFalse: [ ^ aView empty ].
	^ aView composite
		title: 'Mac Application';
		views: ((CwMacApplication fromBundle: self) gtViewsInContext: aContext)
]
