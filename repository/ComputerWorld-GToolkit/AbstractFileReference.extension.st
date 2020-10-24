Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld-GToolkit' }
AbstractFileReference >> gtCwMacApplicationFor: aView inContext: aContext [
	<gtView>
	| app |
	self extension = 'app' ifFalse: [ ^ aView empty ].
	app := CwMacApplication fromBundle: self.
	^ aView composite
		title: app bundle base, ' for Mac';
		views: (app gtViewsInContext: aContext)
]
