"
Motivation: make computing objects like applications, servers, etc come alive. The primary strategy is to document common computing tasks and when possible wrap them in Smalltalk.
!! Installation
In a GToolkit (preferably) or Pharo (v. 8 best supported at time of writing), do the following:
[[[language=smalltalk
[ EpMonitor current disable.
	[ Metacello new
		baseline: 'ComputerWorld';
		repository: 'github://seandenigris/Computer-World';
		onConflictUseLoaded;
		load ] ensure: [ EpMonitor current enable ].
	#SuperuserDB asClass restoreLastBackup.
	#ComputerWorldDB asClass restoreLastBackup.
] fork
]]]
N.B. you only have to do the outer fork if on GT and you want the UI to stay responsive during the load.
!! Features
!!Mac Control
The primary entry point is ${class:CwMac}$.
!!! Server Management
A good place to start is ${class:CwServer}$.  There are also IP addresses, users and privileges, mac addresses. Actions include ""SSH as admin"".
"
Class {
	#name : #BaselineOfComputerWorld,
	#superclass : #BaselineOf,
	#category : #BaselineOfComputerWorld
}

{ #category : #configuration }
BaselineOfComputerWorld class >> dataFolder [
	^ FileLocator dynabookData / 'Computer World'
]

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
		spec package: 'ComputerWorld' with: [ spec requires: #(BabyPhexample CPanel ExternalWebBrowser Magritte NeoJSON "for BTT" OSShell PharoEnhancements ResourcesLive SimpleApplescript Superuser Tempfile) ] ].
	
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
