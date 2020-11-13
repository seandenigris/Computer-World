Class {
	#name : #BaselineOfComputerWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfComputerWorld
}

{ #category : #baseline }
BaselineOfComputerWorld >> baseline: spec [
  <baseline>

	spec for: #'common' do: [
		spec
			baseline: 'BabyPhexample' with: [
				spec repository: 'github://seandenigris/Baby-Phexample' ];
			baseline: 'CPanel' with: [
				spec repository: 'github://seandenigris/cPanel-Live' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser' ];
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON' ];
			baseline: 'OSShell' with: [
				spec repository: 'github://seandenigris/Pharo-Shell' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/ResourcesLive' ];
			baseline: 'SimpleApplescript' with: [
				spec repository: 'github://seandenigris/Applescript-St' ];
			baseline: 'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser' ];
			baseline: 'Tempfile' with: [
				spec repository: 'github://seandenigris/TempfileSt' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample CPanel ExternalWebBrowser Magritte NeoJSON "for BTT" OSShell PharoEnhancements ResourcesLive SimpleApplescript Superuser ) ] ].
	
	spec for: #GToolkit do: [ 
		spec package: 'ComputerWorld-GToolkit' with: [ spec requires: #(ComputerWorld) ] ]

]

{ #category : #accessing }
BaselineOfComputerWorld >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #() ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfComputerWorld >> isGTImage [
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'GToolkit-' ]
]

{ #category : #'post load' }
BaselineOfComputerWorld >> setUpIDE [
	| rootFolder |
	rootFolder := FileLocator dynabookData / 'Computer World'.
	
	"Old-style GT"
	GTPlayBook
		cacheDirectory: (rootFolder / 'play-cache') ensureCreateDirectory;
		stashDirectory: (rootFolder / 'play-stash') ensureCreateDirectory.
	
	"Gtoolkit"
	Smalltalk globals
		at: #XdPlaygroundSettings
		ifPresent: [ :cls | cls directory: (rootFolder / 'xdocs') ensureCreateDirectory ].
	
	"Epicea"
	OmSessionStore defaultBaseLocator: rootFolder / 'ombu-sessions'.
	EpMonitor restart.
]
