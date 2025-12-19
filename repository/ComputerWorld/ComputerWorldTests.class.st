Class {
	#name : 'ComputerWorldTests',
	#superclass : 'TestCase',
	#category : 'ComputerWorld-Specification',
	#package : 'ComputerWorld',
	#tag : 'Specification'
}

{ #category : 'as yet unclassified' }
ComputerWorldTests >> testDownloading [

	| cw software |
	cw := ComputerWorld new.
	software := cw softwareNamed: '1Password'.
"	software downloadFrom: 'http://agilebits.com/downloads/1Password/Mac' asUrl."
	self flag: #pending.
]

{ #category : 'as yet unclassified' }
ComputerWorldTests >> testDownloadingOnPageLoad [
	"When 1Password's download link is clicked, a page is loaded, and the file is simultaneously downloaded (I guess via JS). So we need to open the page in a browser to start the file downloading"

	| cw software |
	cw := ComputerWorld new.
	software := cw softwareNamed: '1Password'.
"	software downloadByOpening: 'http://agilebits.com/downloads/1Password/Mac' asUrl."
	self flag: #pending.
]

{ #category : 'as yet unclassified' }
ComputerWorldTests >> testLearnAboutSoftware [

	| cw |
	cw := ComputerWorld new.
	cw softwareNamed: '1Password'.
	cw software should be anySatisfy: [ :e | e name = '1Password' ].
]
