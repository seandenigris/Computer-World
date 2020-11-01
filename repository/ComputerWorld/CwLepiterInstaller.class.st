Class {
	#name : #CwLepiterInstaller,
	#superclass : #RlResource,
	#category : #'ComputerWorld-Mac'
}

{ #category : #examples }
CwLepiterInstaller class >> example [
	^ self
		given: [ FileLocator home / 'Downloads' / 'Lepiter-v0.5.109.dmg' ]
		when: [ :diskImageFile | 
			(self on: diskImageFile)
				install;
				yourself ]
		then: [ 
			self assert: (FileLocator dynabookData parent / 'vms' / 'le-0.5.109-x64' / 'Lepiter.app') exists.
			self assert: (FileLocator dynabookData parent / 'Working Images' / 'Lepiter 0.5.109' / 'Lepiter 0.5.109.image') exists ]
]

{ #category : #accessing }
CwLepiterInstaller class >> fileExtensions [
	^ #('dmg')
]

{ #category : #testing }
CwLepiterInstaller class >> isClassFor: file [
	^ (super isClassFor: file) and: [ file basename beginsWith: 'Lepiter' ]
]

{ #category : #accessing }
CwLepiterInstaller >> bundle [
	^ '/Volumes/Lepiter' asFileReference / self bundleName
]

{ #category : #accessing }
CwLepiterInstaller >> bundleName [
	^ CwLepiter bundle basename
]

{ #category : #accessing }
CwLepiterInstaller >> copy: source to: target [
	SuGenericUnixCommand new
		template: 'cp -R {source} {target}';
		argumentSource: { 
			#source -> source.
			#target -> target } asDictionary;
		run. 
]

{ #category : #accessing }
CwLepiterInstaller >> install [
	self mount.
	self installVM.
	self installImage.
]

{ #category : #accessing }
CwLepiterInstaller >> installImage [
	| imageSourceFolder targetFolder installationName |
	installationName := 'Lepiter ', self version.
	imageSourceFolder := self targetBundle / 'Contents' / 'MacOS'.
	targetFolder := (FileLocator dynabookData parent / 'Working Images'
		/ installationName) ensureCreateDirectory.
	self move: imageSourceFolder / 'Lepiter.image' to: targetFolder / installationName , 'image'.
	self move: imageSourceFolder / 'Lepiter.changes' to: targetFolder / installationName , 'changes'.
	self move: imageSourceFolder / 'gt-extra' to: targetFolder / 'gt-extra'.
	(targetFolder / 'pharo.version') ensureCreateFile writeStreamDo: [ :str | str nextPutAll: 'le-', self version ]
]

{ #category : #accessing }
CwLepiterInstaller >> installVM [
	"We'll install everything - even the image files - because we know we can move them from there, but the source might be read-only (e.g. a mounted dmg)"
	self copy: self bundle to: self targetBundle.
	(CwLepiter fromBundle: self targetBundle) unquarantine.
]

{ #category : #accessing }
CwLepiterInstaller >> isInstalled [
	| installationLocations |
	installationLocations := { CwLepiter bundle parent. FileLocator dynabookData / 'vms' / self targetVM_ParentName }.
	^ installationLocations anySatisfy: [ :e | (e / self bundleName) exists ].
]

{ #category : #accessing }
CwLepiterInstaller >> mount [
	SuGenericUnixCommand new
		template: 'hdiutil attach {diskImage}';
		argumentAt: #diskImage put: self file;
		run.
]

{ #category : #accessing }
CwLepiterInstaller >> move: source to: target [

	SuGenericUnixCommand new
		template: 'mv {source} {target}';
		argumentSource: {
			#source -> source.
			#target -> target } asDictionary;
		run.
]

{ #category : #accessing }
CwLepiterInstaller >> targetBundle [
	^ (FileLocator dynabookData parent / 'vms' / self targetVM_ParentName)
		ensureCreateDirectory / self bundleName
]

{ #category : #accessing }
CwLepiterInstaller >> targetVM_ParentName [
	^ 'le-' , self version, '-x64'
]

{ #category : #accessing }
CwLepiterInstaller >> version [
	^ self file base allButFirst: 'Lepiter-v' size
]
