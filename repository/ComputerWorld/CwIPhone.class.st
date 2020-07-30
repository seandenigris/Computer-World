Class {
	#name : #CwIPhone,
	#superclass : #Object,
	#category : #'ComputerWorld-Core'
}

{ #category : #'as yet unclassified' }
CwIPhone >> multimediaRootPath [
	"Contains multiple subfolders of the form ###APPLE (e.g. 103APPLE) with the actual photos and videos"
	^ Path from: 'Internal Storage/DCIM'
]
