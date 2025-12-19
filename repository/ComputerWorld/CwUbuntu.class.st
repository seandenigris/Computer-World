Class {
	#name : 'CwUbuntu',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'accessing' }
CwUbuntu class >> minimumSystemRequirements [
	Smalltalk tools webBrowser open: 'https://help.ubuntu.com/community/Installation/SystemRequirements#Ubuntu_Desktop_Edition'.
	
	self notify: '- Hard Drive: Desktop says it needs 8GB space, but would not install in a VB so-equipped. In very light use for about a year, useage was about 12GB, so 16GB is doable but 32GB might be safer (although apparently you can always increase the size via VB command line
- RAM: 4GB seems to be working okay (IIRC that was the Ubuntu min req.)
- Processor: 1 core working okay, in process of comparing to 2 cores; there were forums about problems with CPU settings (e.g. nested paging, paravirtualization), but haven''t noticed anything.
- Graphics: ***The VB-recommended 1MB led to serious hanging when e.g. DNDing windows. 32MB eliminated that problem.
'
]

{ #category : 'as yet unclassified' }
CwUbuntu class >> verifyISO: file [

	CwUbuntuHash verify: file.
]

{ #category : 'as yet unclassified' }
CwUbuntu >> fixFlash [
	"https://gist.github.com/seandenigris/4505931fa5860d567f6c"
]
