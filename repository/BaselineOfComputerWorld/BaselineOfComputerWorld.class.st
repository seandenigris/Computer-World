Class {
	#name : #BaselineOfComputerWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfComputerWorld
}

{ #category : #baseline }
BaselineOfComputerWorld >> baseline: spec [
  <baseline>

	spec for: #'common' do: [
		spec postLoadDoIt: #'postLoad'.
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
			baseline: 'SimpleApplescript' with: [
				spec repository: 'github://seandenigris/Applescript-St' ];
			baseline: 'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser' ];
			baseline: 'Tempfile' with: [
				spec repository: 'github://seandenigris/TempfileSt' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample CPanel ExternalWebBrowser Magritte NeoJSON "for BTT" OSShell PharoEnhancements SimpleApplescript Superuser ) ] ].

]

{ #category : #'post load' }
BaselineOfComputerWorld >> postLoad [
	| rootFolder |
	rootFolder := FileLocator dynabookData / 'Computer World'.
	GTPlayBook 
		cacheDirectory: rootFolder / 'play-cache';
		stashDirectory: rootFolder / 'play-stash'.
]
