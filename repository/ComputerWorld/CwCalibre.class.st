Class {
	#name : #CwCalibre,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwCalibre >> downloadUrl [
	^ 'https://github.com/kovidgoyal/calibre/releases/download/v2.45.0/calibre-2.45.0.dmg' asUrl
]

{ #category : #'as yet unclassified' }
CwCalibre >> downloadUrlExample [
	"Homebrew uses insecure methods. See https://github.com/caskroom/homebrew-cask/blob/master/Casks/calibre.rb"
	^ 'https://github.com/kovidgoyal/calibre/releases/download/v2.45.0/calibre-2.45.0.dmg' asUrl
]
