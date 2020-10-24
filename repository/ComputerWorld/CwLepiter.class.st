Class {
	#name : #CwLepiter,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwLepiter class >> bundle [
	^ '/Applications/Lepiter.app' asFileReference
]

{ #category : #accessing }
CwLepiter >> install [
	self installVM.
	self installImage.
]

{ #category : #accessing }
CwLepiter >> installImage [
	| imageFolder targetFolder installationName targetBundle moveCommand |
	installationName := 'Lepiter 0.5.109'.
	targetBundle := (FileLocator dynabookData parent / 'vms' / 'le-0.5.109-x64') ensureCreateDirectory / self bundle basename.
	imageFolder := targetBundle / 'Contents' / 'MacOS'.
	targetFolder := (FileLocator dynabookData parent / 'Working Images' / installationName) ensureCreateDirectory.
	moveCommand := SuGenericUnixCommand new
		template: 'mv {source} {target}';
		yourself.
	moveCommand
		argumentSource: { 
			#source -> (imageFolder / 'Lepiter.image').
			#target -> (targetFolder / installationName, 'image') } asDictionary;
		run.
	moveCommand
		argumentSource: { 
			#source -> (imageFolder / 'Lepiter.changes').
			#target -> (targetFolder / installationName, 'changes') } asDictionary;
		run.
	moveCommand
		argumentSource: { 
			#source -> (imageFolder / 'gt-extra').
			#target -> (targetFolder / 'gt-extra') } asDictionary;
		run.
]

{ #category : #accessing }
CwLepiter >> installVM [
	| targetBundle installationName |
	installationName := 'le-0.5.109-x64'.
	targetBundle := (FileLocator dynabookData parent / 'vms' / installationName) ensureCreateDirectory / self bundle basename.
	SuGenericUnixCommand new
		template: 'cp -R {source} {target}';
		argumentSource: { 
			#source -> self bundle.
			#target -> targetBundle } asDictionary;
		run.
	(self class fromBundle: targetBundle) unquarantine.
]

{ #category : #accessing }
CwLepiter >> isInstalled [
	| installationLocations |
	installationLocations := { self class bundle parent. FileLocator dynabookData / 'vms' }.
	^ installationLocations anySatisfy: [ :e | self bundle isChildOf: e ].
]
