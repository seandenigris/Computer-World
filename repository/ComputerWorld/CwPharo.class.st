Class {
	#name : 'CwPharo',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwPharo >> addToMacDock [

	CwMacDock new add: '/Applications/Pharo.app' asFileReference
]
