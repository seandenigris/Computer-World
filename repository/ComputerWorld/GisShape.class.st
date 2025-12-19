Class {
	#name : 'GisShape',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#instVars : [
		'polygon'
	],
	#category : 'ComputerWorld-GIS',
	#package : 'ComputerWorld',
	#tag : 'GIS'
}

{ #category : 'as yet unclassified' }
GisShape >> calculatedBounds [
	"Answer the bounds of the receiver calculated from the
	receiver's vertices."

	|tl br|
	self polygon vertices ifEmpty: [^nil].
	tl := br := self polygon vertices first.
	self polygon vertices allButFirstDo: [:v |
		tl := tl min: v.
		br := br max: v].
	^tl corner: br
]

{ #category : 'as yet unclassified' }
GisShape >> center [

	^ self calculatedBounds topLeft + self calculatedBounds bottomRight / 2.0
]

{ #category : 'as yet unclassified' }
GisShape >> containsPoint: aPoint [

	^ self polygon containsPoint: aPoint
]

{ #category : 'as yet unclassified' }
GisShape >> googleMapsGtActionFor: anAction [
    <gtAction>
    ^ anAction explicit stencil: [
        BrButton new
            aptitude: BrGlamorousButtonWithIconAptitude;
            action:  [ WebBrowser openOn: self googleMapsUrl ];
            icon: BrGlamorousVectorIcons link;
            label: 'Open in Web Browser' translated ]
]

{ #category : 'as yet unclassified' }
GisShape >> googleMapsUrl [


	| template urlString |
	template := 'http://maps.google.com/maps?z=20&t=k&q=loc:{lat}+{long}'.
	urlString := template format: {
		#lat -> self center y asFloat.
		#long -> self center x asFloat
	} asDictionary.
		
	^ urlString asUrl
	
	"Adapted from http://stackoverflow.com/questions/2660201/ddg#9919251"
]

{ #category : 'as yet unclassified' }
GisShape >> polygon [

	| vertices |
	

	polygon ifNotNil: [ ^ polygon ].
	
	vertices := ((self rawDataAt: #geometry) at: #rings) first collect: [ :ary | Point x: ary first y: ary second ].
	^ polygon := Polygon vertices: vertices
]
