Class {
	#name : #RlZipArchive,
	#superclass : #RlResource,
	#category : 'ComputerWorld-Mac'
}

{ #category : #accessing }
RlZipArchive class >> fileExtensions [
	^ #('zip')
]

{ #category : #accessing }
RlZipArchive >> decompressTo: folder [
	SuUnzip new source: self file; target: folder; run.
]
