Class {
	#name : 'ComputerWorldDB',
	#superclass : 'SpFileDatabase',
	#category : 'ComputerWorld-Persistence',
	#package : 'ComputerWorld',
	#tag : 'Persistence'
}

{ #category : 'accessing' }
ComputerWorldDB class >> backupDirectoryParent [
	
	^ FileLocator dynabookData / 'Computer World'
]

{ #category : 'loading/saving' }
ComputerWorldDB class >> schema [

	^ {
			ComputerWorld.
			CPanelDB.
			CwBetterTouchTool.
			CwEBook.
			CwIPAddressRange.
			CwNetworkDevice.
			CwPharoCast.
			CwSoftwareCatalog.
			ResourcesLiveDB.
		}.
]
