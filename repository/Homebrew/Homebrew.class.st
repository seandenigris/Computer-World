Class {
	#name : #Homebrew,
	#superclass : #Object,
	#category : 'Homebrew'
}

{ #category : #'as yet unclassified' }
Homebrew class >> doctor [
	"#install outputs a message to do this"

	| exitCode |
	exitCode := NBMacShell run: '/usr/local/bin/brew doctor'.
	exitCode = 0 ifFalse: [ self error: 'brew doctor failed' ].
]

{ #category : #'as yet unclassified' }
Homebrew class >> install [
	"From http://brew.sh/
	run #doctor immediately after and respond to output"

	NBMacShell run: 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"'.
]
