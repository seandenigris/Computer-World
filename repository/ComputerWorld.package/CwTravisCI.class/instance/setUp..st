as yet unclassified
setUp: folder
	folder exists ifFalse: [ self error: 'No repo at ', folder fullName ].
	self
		addStonFileFor: folder;
		addYmlFileFor: folder