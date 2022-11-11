Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld-GToolkit' }
AbstractFileReference >> gtCwMacApplicationFor: aView [
	<gtView>
	| app |
	
	self extension = 'app' ifFalse: [ ^ aView empty ].
	
	app := CwMacApplication fromBundle: self.
	^ aView forward
		title: app bundle base, ' for Mac';
		object: [ app ];
		priority: 1;
		view: #gtMetaFor:;
		inspectButtonFor: app
]
