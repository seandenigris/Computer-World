as yet unclassified
excludePreviewsFromTimeMachine
	"They can be huge and can be easily regenerated
	Reference: http://macperformanceguide.com/Mac-TimeMachine-excluding.html"
	CwTimeMachine new exclude: self previewFile.
	self assert: (CwTimeMachine new isExcluded: self new previewFile) runInTerminal = 0