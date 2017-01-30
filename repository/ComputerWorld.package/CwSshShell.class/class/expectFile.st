private
expectFile

	self expectFileReference exists ifFalse: [ self downloadExpectScript ].
	^ self expectFileReference.