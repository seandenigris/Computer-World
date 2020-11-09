Class {
	#name : #RlZipArchive,
	#superclass : #RlResource,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
RlZipArchive class >> fileExtensions [
	^ #('zip')
]

{ #category : #accessing }
RlZipArchive >> decompressTo: folder [
	Su_unzip new source: self file; target: folder; run.
]
