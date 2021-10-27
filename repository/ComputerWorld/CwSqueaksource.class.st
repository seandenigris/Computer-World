Class {
	#name : #CwSqueaksource,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwSqueaksource class >> menuCommandOn: aBuilder [ 

	<worldMenu>
	(aBuilder item: #'Go to Squeaksource') action:[ self openInBrowser ].
]

{ #category : #'as yet unclassified' }
CwSqueaksource class >> mirrorUrl [
	"See http://forum.world.st/ANN-LatAm-Squeaksource-Mirror-td3733190.html"

	^ 'http://www.dsal.cl/squeaksource/' asUrl.
]

{ #category : #'as yet unclassified' }
CwSqueaksource class >> openInbrowser [

	ExternalWebBrowser openOnUrl: 'http://www.squeaksource.com/'.
]
