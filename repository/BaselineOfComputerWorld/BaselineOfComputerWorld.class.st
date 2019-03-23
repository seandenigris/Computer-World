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
			baseline: 'OSShell' with: [
				spec repository: 'github://seandenigris/Pharo-Shell' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser' ];
			baseline: 'Tempfile' with: [
				spec repository: 'github://seandenigris/TempfileSt' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser' ];
			baseline: 'SimpleApplescript' with: [
				spec repository: 'github://seandenigris/Applescript-St' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample OSShell ExternalWebBrowser PharoEnhancements Superuser #'SimpleApplescript') ] ].

]
