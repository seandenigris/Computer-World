Class {
	#name : #CwGToolkitInstaller,
	#superclass : #RlZipArchive,
	#traits : 'CwTGToolkitInstaller',
	#classTraits : 'CwTGToolkitInstaller classTrait',
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwGToolkitInstaller class >> allDownloaded [
	^ FileLocator downloads files
		select: [ :e | { self. CwLepiterInstaller } anySatisfy: [ :cls | cls isClassFor: e ] ]
		thenCollect: [ :e | RlResource on: e ]
]

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
CwGToolkitInstaller >> bundleName [
	^ 'GlamorousToolkit.app'
]

{ #category : #accessing }
CwGToolkitInstaller >> bundleParent [
	^ '/Applications' asFileReference
]

{ #category : #accessing }
CwGToolkitInstaller >> imageSourceFolder [
	^ self targetBundle parent.
]

{ #category : #accessing }
CwGToolkitInstaller >> installVMFiles [
	Tempfile do: [ :folder |
		self decompressTo: folder.
		self move: folder / self file base to: self targetBundle parent ].
]

{ #category : #accessing }
CwGToolkitInstaller >> installationLocations [
	^ { FileLocator dynabookData / 'vms' / self targetVM_ParentName }.
]

{ #category : #accessing }
CwGToolkitInstaller >> productName [
	^ 'GT'
]

{ #category : #accessing }
CwGToolkitInstaller >> versionPrefix [
	^ 'GlamorousToolkitOSX64-v'
]
