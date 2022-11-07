"
What if interfacing with computing artifacts felt like your mental models had come alive?

Interacting programmatically with computing artifacts (e.g. servers, applications, windows, peripherals) can be like the proverbial blind men describing the elephant. To do XYZ in this app, was it a CLI util, applescript, JS? How do I install it? What was its arcane syntax? 

But why?! These artifacts are experienced as objects in our minds. What if our interfaces brought them to life with the same tangibility and clarity?

Rather than descend into the exising chaos of endless ""tips and tricks"" to hack in missing features, becoming the ""high priests of a low cult"" Alan Kay has warned us about, we choose to create a beautiful, sane model that matches our existing reality. Join us.

# Features
A very incomplete list...

## Mac Control
The primary entry point is {{gtClass:CwMac}}.

## Server Management
A good place to start is {{gtClass:CwServer}}.  There are also IP addresses, users and privileges, mac addresses. Actions include ""SSH as admin"".
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

{ #category : #testing }
BaselineOfComputerWorld class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfComputerWorld >> baseline: spec [
  <baseline>

	spec for: #'common' do: [
		spec
			baseline: 'ContainersOrderedSet' with: [ 
				spec repository: 'github://pharo-containers/Containers-OrderedSet' ];
			baseline: 'CPanel' with: [
				spec repository: 'github://seandenigris/cPanel-Live' ];
			baseline: 'ExternalWebBrowser' with: [
				spec repository: 'github://seandenigris/Pharo-Web-Browser' ];
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'OSShell' with: [
				spec repository: 'github://seandenigris/Pharo-Shell' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'ResourcesLive' with: [
				spec repository: 'github://seandenigris/Resources-Live' ];
			baseline: 'SimpleApplescript' with: [
				spec repository: 'github://seandenigris/Applescript-St' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://seandenigris/Mocketry' ];
			baseline: 'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser' ];
			baseline: 'Tempfile' with: [
				spec repository: 'github://seandenigris/TempfileSt' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(ContainersOrderedSet CPanel ExternalWebBrowser Magritte Mocketry OSShell PharoEnhancements ResourcesLive SimpleApplescript SimplePersistence Superuser Tempfile) ] ].
		
	spec for: #notGToolkit do: [ 
		spec baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON' ].
		spec package: 'ComputerWorld' with: [ spec requires: #(NeoJSON "for BTT") ] ].
	
	spec for: #GToolkit do: [ 
		spec package: 'ComputerWorld-GToolkit' with: [ spec requires: #(ComputerWorld) ] ]

]

{ #category : #accessing }
BaselineOfComputerWorld >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfComputerWorld >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
