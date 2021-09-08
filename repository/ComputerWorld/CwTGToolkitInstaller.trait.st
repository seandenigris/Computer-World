"
I exist to share behavior between Lepiter and GT installer, while allowing each to inherit from unrelated ancestors. That's important because we want GT to recognize each as an RlResource so that the proper views are shown, but the way ResourcesLive determines what to show is a negotiation between a class and its subclasses. Thus, if GT installer was not a zip archive subclass, zip would be in a race condition with it.
"
Trait {
	#name : #CwTGToolkitInstaller,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwTGToolkitInstaller >> bundle [
	^ self bundleParent / self bundleName
]

{ #category : #accessing }
CwTGToolkitInstaller >> copy: source to: target [
	SuGenericUnixCommand new
		template: 'cp -R {source} {target}';
		argumentSource: { 
			#source -> source.
			#target -> target } asDictionary;
		run. 
]

{ #category : #accessing }
CwTGToolkitInstaller >> install [
	Tempfile do: [ :folder |
		self decompressTo: folder.
		self installVMFrom: folder.
		self installImageFrom: folder. ]
]

{ #category : #accessing }
CwTGToolkitInstaller >> installImageFrom: folder [
	| targetFolder installationName supportFolders |
	installationName := self installationPrefix, ' ', self version.
	targetFolder := (FileLocator dynabookData parent / 'Working Images'
		/ installationName) ensureCreateDirectory.
	self move: folder / self productName, 'image' to: targetFolder / installationName , 'image'.
	self move: folder / self productName, 'changes' to: targetFolder / installationName , 'changes'.
	supportFolders := folder directories reject: [ :e | 
		e extension = 'app' or: [ e basename = 'Plugins' ] ].
	supportFolders do: [ :e | self move: e to: targetFolder / e basename ].
	(targetFolder / 'pharo.version') ensureCreateFile writeStreamDo: [ :str | str nextPutAll: self versionID ]
]

{ #category : #accessing }
CwTGToolkitInstaller >> installVMFrom: folder [

	self installVMFilesFrom: folder.
	self macApplication unquarantineCommand run
]

{ #category : #accessing }
CwTGToolkitInstaller >> isInstalled [
	^ self installationLocations anySatisfy: [ :e | (e / self bundleName) exists ].
]

{ #category : #accessing }
CwTGToolkitInstaller >> move: sourceFile to: targetFile [

	| targetArgument sourceArgument |
	"If the target is an existing directory, mv will move source file(s) into it; otherwise it renames the source as the target (per mv man page)"
	sourceArgument := (sourceFile isDirectory and: [ targetFile exists ]) 
		ifTrue: [ 
			"Adapted from https://askubuntu.com/a/172634; NB. * can't be inside the quotes or the command fails"
			sourceFile fullName surroundedByDoubleQuotes, '/*' ]
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
CwTGToolkitInstaller >> productAbbreviation [
	^ self productName first: 2
]

{ #category : #accessing }
CwTGToolkitInstaller >> targetBundle [
	^ (FileLocator dynabookData parent / 'vms' / self targetVM_ParentName)
		ensureCreateDirectory / self bundleName
]

{ #category : #accessing }
CwTGToolkitInstaller >> targetVM_ParentName [
	^ self versionID , '-x64'
]

{ #category : #accessing }
CwTGToolkitInstaller >> version [
	^ (self file base splitOn: $-) last allButFirst
]

{ #category : #accessing }
CwTGToolkitInstaller >> versionID [
	^ self productAbbreviation asLowercase , '-' , self version
]
