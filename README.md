[![Build Status](https://travis-ci.org/seandenigris/Computer-World.png?branch=master)](https://travis-ci.org/seandenigris/Computer-World)

# Computer-World

Motivation: make computing objects like applications, servers, etc come alive. The primary strategy is to document common computing tasks and when possible wrap them in Smalltalk.

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
