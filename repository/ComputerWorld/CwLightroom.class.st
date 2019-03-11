Class {
	#name : #CwLightroom,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwLightroom >> excludePreviewsFromTimeMachine [
	"They can be huge and can be easily regenerated
	Reference: http://macperformanceguide.com/Mac-TimeMachine-excluding.html"
	CwTimeMachine new exclude: self previewFile.
	self assert: (CwTimeMachine new isExcluded: self new previewFile) runInTerminal = 0
]

{ #category : #'as yet unclassified' }
CwLightroom >> movePhotosFrom: source ToExternalDrive: target [
	
	| moveTemplate moveCommand linkTemplate linkCommand |
	self error: 'Not tested! I recommend you step through and verify!!'.
	moveTemplate := 'mv "{1}" "{2}"'.
	moveCommand := moveTemplate format: { source fullName. target fullName }.
	LibC system: moveCommand.
	
	linkTemplate := 'ln -s "{real}" "{link}"'.
	linkCommand := linkTemplate format: { 
		#real -> target.
		#link -> source } asDictionary.
	LibC system: linkCommand
]

{ #category : #'as yet unclassified' }
CwLightroom >> previewFile [
	^ FileLocator home / 'Pictures' / 'Lightroom' / 'Lightroom Catalog Previews.lrdata'
]
