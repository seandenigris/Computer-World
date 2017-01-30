as yet unclassified
scrubMetadataFrom: file

	self removeAllMetadataFrom: file.
	self restoreSafeMetadataTo: file.