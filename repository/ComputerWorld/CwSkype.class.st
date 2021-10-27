Class {
	#name : #CwSkype,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #installation }
CwSkype class >> install [
	"Secured via https: https://github.com/caskroom/homebrew-cask/blob/master/Casks/skype.rb"
	'brew cask install skype'
]
