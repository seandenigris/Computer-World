Class {
	#name : 'CwFolderActions',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac'
}

{ #category : 'private' }
CwFolderActions class >> attach: handlerScriptFile to: monitoredFile [
	"Both arguments are FileReference instances"

	| attachScriptTemplate attachScriptSource |
	self ensureEnabled.
	attachScriptTemplate := 'set target_folder to POSIX file "{1}"
set script_file to POSIX file "{2}"

tell application "System Events"
	attach action to target_folder as alias using script_file as string
end tell'.
	attachScriptSource := attachScriptTemplate format: { monitoredFile. handlerScriptFile fullName }.
	Applescript doIt: attachScriptSource.
]

{ #category : 'private' }
CwFolderActions class >> compile: applescriptString to: aFileReference [

	| commandTemplate commandString p |
	commandTemplate := '/usr/bin/osacompile -o {1} <<END_S
{2}
END_S'.
	commandString := commandTemplate format: { aFileReference fullName surroundedByDoubleQuotes. applescriptString }.
	"Heredocs require very precise line breaks. Mac expects lfs, but Pharo defaults to crs"
	commandString := commandString copyReplaceAll: Character cr asString with: Character lf asString.
	p := PipeableOSProcess waitForCommand: commandString.
	p succeeded ifFalse: [ self error: p errorUpToEndOfFile ].
]

{ #category : 'API' }
CwFolderActions class >> disable [

	self enabled: false.
]

{ #category : 'API' }
CwFolderActions class >> enable [

	self enabled: true.
]

{ #category : 'turning on/off' }
CwFolderActions class >> enableViaDefaults [

	self shouldBeImplemented. 'defaults write com.apple.FolderActions folderActionsEnabled -bool true'.
]

{ #category : 'private' }
CwFolderActions class >> enabled: aBoolean [

	Applescript doIt: 'tell application "System Events" to set folder actions enabled to ', aBoolean asString.
]

{ #category : 'private' }
CwFolderActions class >> ensureEnabled [

	self isEnabled ifFalse: [ self enable ].
]

{ #category : 'private' }
CwFolderActions class >> install: aString asHandlerFor: aFileReference [

	| handlerScriptFile handlerTemplate handlerSource |
	handlerScriptFile := FileLocator home / 'Library' / 'Scripts'/ 'Folder Action Scripts' / ('onFileAddedTo', aFileReference base), 'scpt'.
	handlerTemplate := 'on adding folder items to this_folder after receiving added_items
	{1}
end adding folder items to'.
	handlerSource := handlerTemplate format: { aString }.
	self compile: handlerSource to: handlerScriptFile.
	^ handlerScriptFile.
]

{ #category : 'private' }
CwFolderActions class >> isEnabled [

	^ Applescript doIt: 'tell application "System Events" to get folder actions enabled'.
]

{ #category : 'API' }
CwFolderActions class >> onFileAddedTo: aFileReference run: aString [ 

	| handlerScriptFile |
	handlerScriptFile := self install: aString asHandlerFor: aFileReference.
	self attach: handlerScriptFile to: aFileReference.
]
