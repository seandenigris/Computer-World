Class {
	#name : #ComputerWorldDB,
	#superclass : #SpFileDatabase,
	#category : 'ComputerWorld-Persistence'
}

{ #category : #accessing }
ComputerWorldDB class >> backupDirectoryParent [
	
	^ FileLocator dynabookData / 'Computer World'
]

{ #category : #'loading/saving' }
ComputerWorldDB class >> schema [

	^ { 
			ComputerWorld.
			CPanelDB.
			CwBetterTouchTool.
			CwEBook.
			CwHomebrew.
			CwIPAddressRange.
			CwMacApplication.
			CwNetworkDevice.
			CwPharoCast.
			ResourcesLiveDB
		}.
]
