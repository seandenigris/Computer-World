Class {
	#name : #CwFolderAction,
	#superclass : #Object,
	#category : 'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwFolderAction class >> attach: aScript to: aFolder [

	
]

{ #category : #'as yet unclassified' }
CwFolderAction class >> enable [

	OSProcess command: 'defaults write com.apple.FolderActions folderActionsEnabled -bool true'.
]

{ #category : #'as yet unclassified' }
CwFolderAction class >> scripts [

	^ self systemScripts, self userScripts.
]

{ #category : #'as yet unclassified' }
CwFolderAction class >> systemScripts [

	^ (FileDirectory on: '/Library/Scripts/Folder Action Scripts/') fileNames.
]

{ #category : #'as yet unclassified' }
CwFolderAction class >> userScripts [

	^ (FileLocator home / 'Library/Scripts/Folder Action Scripts') fileNames.
]
