Class {
	#name : 'CwGToolkitInstaller',
	#superclass : 'RlZipArchive',
	#traits : 'CwTGToolkitInstaller',
	#classTraits : 'CwTGToolkitInstaller classTrait',
	#category : 'ComputerWorld-Mac',
	#package : 'ComputerWorld',
	#tag : 'Mac'
}

{ #category : 'accessing' }
CwGToolkitInstaller class >> allDownloaded [
	^ FileLocator downloads files
		select: [ :e | self isClassFor: e ]
		thenCollect: [ :e | RlResource on: e ]
]

{ #category : 'examples' }
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

{ #category : 'testing' }
CwGToolkitInstaller class >> isClassFor: file [
	^ (super isClassFor: file) and: [ file basename beginsWith: 'GlamorousToolkit' ]
]

{ #category : 'accessing' }
CwGToolkitInstaller >> bundleName [
	^ 'GlamorousToolkit.app'
]

{ #category : 'accessing' }
CwGToolkitInstaller >> bundleParent [
	^ '/Applications' asFileReference
]

{ #category : 'accessing' }
CwGToolkitInstaller >> installVMFilesFrom: folder [
	| sourcesFile |
	self move: folder / self bundleName to: self targetBundle parent / self bundleName.
	
	sourcesFile := (folder filesMatching: '*.sources') first.
	self move: sourcesFile to: self targetBundle parent.
]

{ #category : 'accessing' }
CwGToolkitInstaller >> installationLocations [
	^ { FileLocator dynabookData / 'vms' / self targetVM_ParentName }.
]

{ #category : 'accessing' }
CwGToolkitInstaller >> installationPrefix [
	^ self productAbbreviation
]

{ #category : 'accessing' }
CwGToolkitInstaller >> macApplication [

	^ CwMacApplication fromBundle: self targetBundle
]

{ #category : 'accessing' }
CwGToolkitInstaller >> productAbbreviation [
	^ 'GT'
]

{ #category : 'accessing' }
CwGToolkitInstaller >> productName [
	^ 'GlamorousToolkit'
]
