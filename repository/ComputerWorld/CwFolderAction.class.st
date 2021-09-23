Class {
	#name : 'CwFolderAction',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac'
}

{ #category : 'as yet unclassified' }
CwFolderAction class >> attach: aScript to: aFolder [

	
]

{ #category : 'as yet unclassified' }
CwFolderAction class >> enable [

	Smalltalk tools shell new run: 'defaults write com.apple.FolderActions folderActionsEnabled -bool true'.
]

{ #category : 'as yet unclassified' }
CwFolderAction class >> scripts [

	^ self systemScripts, self userScripts.
]

{ #category : 'as yet unclassified' }
CwFolderAction class >> systemScripts [

	^ '/Library/Scripts/Folder Action Scripts/' asFileReference fileNames.
]

{ #category : 'as yet unclassified' }
CwFolderAction class >> userScripts [

	^ (FileLocator home / 'Library/Scripts/Folder Action Scripts') fileNames.
]
