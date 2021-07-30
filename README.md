[![Build Status](https://travis-ci.org/seandenigris/Computer-World.png?branch=master)](https://travis-ci.org/seandenigris/Computer-World)

# Computer-World

What if interfacing with computing artifacts felt like your  mental models had come alive?

Interacting programmatically with high-level computing artifacts (e.g. servers, applications, windows, peripherals) can be like the proverbial blind men feeling the elephant. To do XYZ in this app, was it a CLI util, applescript, JS? How do I install it? What was its arcane syntax? 

But why?! These artifacts are experienced as objects in our minds. What if our interfaces brought them to life with the same tangibility and clarity?

Rather than descend into the exising chaos of endless "tips and tricks" to hack in missing features, becoming the "high priests of a low cult" Alan Kay has warned us about, we choose to create a beautiful, sane model that matches our existing reality. Join us.

## Installation
In a GToolkit (preferably) or Pharo (v. 8 best supported at time of writing), do the following:
```smalltalk
[ EpMonitor current disable.
	[ Metacello new
		baseline: 'ComputerWorld';
		repository: 'github://seandenigris/Computer-World';
		onConflictUseLoaded;
		load ] ensure: [ EpMonitor current enable ].
	#SuperuserDB asClass restoreLastBackup.
	#ComputerWorldDB asClass restoreLastBackup.
] fork
```
N.B. you only have to do the outer fork if on GT and you want the UI to stay responsive during the load.

## Features

### Server Management
![Screen Shot 2021-04-30 at 10 03 53 AM](https://user-images.githubusercontent.com/184176/116708691-f593dd00-a99d-11eb-88cc-cc27f3c21a94.png)
A basic implementation has been started. It models IP addresses nicely, users and privileges, mac addresses. Ations include "SSH as admin".
