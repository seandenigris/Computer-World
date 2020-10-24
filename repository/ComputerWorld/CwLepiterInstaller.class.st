Class {
	#name : #CwLepiterInstaller,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwLepiterInstaller class >> example [
	"DMG should already be mounted"
	self new
		version: '0.5.110';
		install
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
	^ 'le-' , self version , '-x64'
]

{ #category : #accessing }
CwLepiterInstaller >> version [
	^ version
]

{ #category : #accessing }
CwLepiterInstaller >> version: anObject [
	version := anObject
]
