Class {
	#name : #CwLepiterInstaller,
	#superclass : #RlResource,
	#traits : 'CwTGToolkitInstaller @ {#traitInstall->#install}',
	#classTraits : 'CwTGToolkitInstaller classTrait',
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
CwLepiterInstaller >> bundleName [
	^ CwLepiter bundle basename
]

{ #category : #accessing }
CwLepiterInstaller >> bundleParent [
	^ '/Volumes/Lepiter' asFileReference
]

{ #category : #accessing }
CwLepiterInstaller >> imageSourceFolder [
	^ self targetBundle / 'Contents' / 'MacOS'.
]

{ #category : #accessing }
CwLepiterInstaller >> install [
	self mount.
	self traitInstall
]

{ #category : #accessing }
CwLepiterInstaller >> installVMFiles [
	"We'll install everything - even the image files - because we know we can move them from there, but the source might be read-only (e.g. a mounted dmg)"
	self copy: self bundle to: self targetBundle.
]

{ #category : #accessing }
CwLepiterInstaller >> installationLocations [
	^ { CwLepiter bundle parent. FileLocator dynabookData / 'vms' / self targetVM_ParentName }.
]

{ #category : #accessing }
CwLepiterInstaller >> mount [
	Su_hdiutil mounting
		argumentAt: #diskImage put: self file;
		run.
]

{ #category : #accessing }
CwLepiterInstaller >> productName [
	^ 'Lepiter'
]

{ #category : #accessing }
CwLepiterInstaller >> versionPrefix [
	^ 'Lepiter-v'
]
