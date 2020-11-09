Class {
	#name : #CwGToolkitInstaller,
	#superclass : #RlZipArchive,
	#category : #'ComputerWorld-Mac'
}

{ #category : #examples }
CwGToolkitInstaller class >> example [
	^ self
		given: [ FileLocator home / 'Downloads' / 'GlamorousToolkitOSX64-v0.8.271.zip' ]
		when: [ :diskImageFile | 
			(self on: diskImageFile)
				install;
				yourself ]
		then: [ 
			self assert: (FileLocator dynabookData parent / 'vms' / 'gt-0.8.271-x64' / 'Lepiter.app') exists.
			self assert: (FileLocator dynabookData parent / 'Working Images' / 'GT 0.8.271' / 'GT 0.8.271') exists ]
]

{ #category : #testing }
CwGToolkitInstaller class >> isClassFor: file [
	^ (super isClassFor: file) and: [ file basename beginsWith: 'GlamorousToolkit' ]
]

{ #category : #accessing }
CwGToolkitInstaller >> bundle [
	^ '/Applications' asFileReference / self bundleName
]

{ #category : #accessing }
CwGToolkitInstaller >> bundleName [
	^ 'GlamorousToolkit.app'
]

{ #category : #accessing }
CwGToolkitInstaller >> install [
	self installVM.
	self installImage.
]

{ #category : #accessing }
CwGToolkitInstaller >> installImage [
	| imageSourceFolder targetFolder installationName |
	installationName := 'GT ', self version.
	imageSourceFolder := self targetBundle parent.
	targetFolder := (FileLocator dynabookData parent / 'Working Images'
		/ installationName) ensureCreateDirectory.
	self move: imageSourceFolder / 'GlamorousToolkit.image' to: targetFolder / installationName , 'image'.
	self move: imageSourceFolder / 'GlamorousToolkit.changes' to: targetFolder / installationName , 'changes'.
	self move: imageSourceFolder / 'gt-extra' to: targetFolder / 'gt-extra'.
	(targetFolder / 'pharo.version') ensureCreateFile writeStreamDo: [ :str | str nextPutAll: 'gt-', self version ]
]

{ #category : #accessing }
CwGToolkitInstaller >> installVM [
	Tempfile do: [ :folder |
		self decompressTo: folder.
		self move: folder / self file base to: self targetBundle parent ].
	(CwMacApplication fromBundle: self targetBundle) unquarantine.
]

{ #category : #accessing }
CwGToolkitInstaller >> isInstalled [
	| installationLocations |
	installationLocations := { FileLocator dynabookData / 'vms' / self targetVM_ParentName }.
	^ installationLocations anySatisfy: [ :e | (e / self bundleName) exists ].
]

{ #category : #accessing }
CwGToolkitInstaller >> move: sourceFile to: targetFile [

	| targetArgument sourceArgument |
	"If the target is an existing directory, mv will move source file(s) into it; otherwise it renames the source as the target (per mv man page)"
	sourceArgument := (sourceFile isDirectory and: [ targetFile exists ]) 
		ifTrue: [ 
			"Adapted from https://askubuntu.com/a/172634; NB. * can't be inside the quotes or the command fails"
			sourceFile fullName surroundedByDoubleQuotes, '/*'  ]
		ifFalse: [ sourceFile ].
	
	"Destination directory should get trailing slash per https://stackoverflow.com/a/24925767"
	targetArgument := targetFile isDirectory 
		ifTrue: [ (targetFile fullName , '/') surroundedByDoubleQuotes ]
		ifFalse: [ targetFile ].
	SuGenericUnixCommand new
		template: 'mv {source} {target}';
		argumentSource: {
			#source -> sourceArgument.
			#target -> targetArgument } asDictionary;
		run.
]

{ #category : #accessing }
CwGToolkitInstaller >> targetBundle [
	| targetVM_Parent |
	targetVM_Parent := FileLocator dynabookData parent / 'vms' / self targetVM_ParentName.
	^ targetVM_Parent ensureCreateDirectory / self bundleName
]

{ #category : #accessing }
CwGToolkitInstaller >> targetVM_ParentName [
	^ 'gt-' , self version, '-x64'
]

{ #category : #accessing }
CwGToolkitInstaller >> version [
	^ self file base allButFirst: 'GlamorousToolkitOSX64-v' size
]
