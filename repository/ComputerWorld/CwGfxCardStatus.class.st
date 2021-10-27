Class {
	#name : #CwGfxCardStatus,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwGfxCardStatus class >> download [
	"Zipped download URL is available over SSL"
	<script>

	^ self websiteURL open.
]

{ #category : #'as yet unclassified' }
CwGfxCardStatus class >> install [
	<script>
	
	self download.
	UIManager default confirm: 'Unzip and move into /Applications'
]

{ #category : #'as yet unclassified' }
CwGfxCardStatus class >> websiteURL [
	^ 'https://gfx.io/' asUrl
]
