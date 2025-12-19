Class {
	#name : 'CwGitLab',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwGitLab class >> verifyKeyFingerprint: aString [
	"See https://about.gitlab.com/gitlab-com/settings/#ssh-host-keys-fingerprints if need to update"
	
	^ aString = 'SHA256:HbW3g8zUjNSksFbqTiUWPWg2Bq1x8xdGUrliXFzSnUw'
]
