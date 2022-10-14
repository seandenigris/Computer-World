Class {
	#name : #CwMacBooks,
	#superclass : #CwMacApplication,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'as yet unclassified' }
CwMacBooks >> iCloudFolder [

	^ FileLocator home / 'Library' / 'Mobile Documents' / 'iCloud~com~apple~iBooks' / 'Documents'
	
	"Reference: https://discussions.apple.com/thread/7292866?answerId=30253944022#30253944022"
]

{ #category : #'as yet unclassified' }
CwMacBooks >> localFolder [

	^ FileLocator home / 'Library' / 'Containers' / 'com.apple.BKAgentService' / 'Data' / 'Documents' / 'iBooks' / 'Books'
	
	"Reference: https://discussions.apple.com/thread/7292866?answerId=30253944022#30253944022"
]
