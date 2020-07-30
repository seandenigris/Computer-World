Class {
	#name : #ComputerWorldDB,
	#superclass : #SpFileDatabase,
	#category : #'ComputerWorld-Persistence'
}

{ #category : #accessing }
ComputerWorldDB class >> backupDirectoryParent [
	
	^ FileLocator dynabookData / 'Computer World'
]

{ #category : #'loading/saving' }
ComputerWorldDB class >> schema [

	^ { 
			ComputerWorld.
			CwBetterTouchTool.
			CwEBook.
			CwHomebrew.
			CwServer.
			CwPharoCast
		}.
]
