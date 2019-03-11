Class {
	#name : #CwAnki,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwAnki >> gitHubRepo [
	^ 'https://github.com/dae/anki/' asUrl
]

{ #category : #'as yet unclassified' }
CwAnki >> installPrerequisites [

	'sudo brew install sip
	mkdir -p ~/Library/Python/2.7/lib/python/site-packages
	echo ''import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")'' >> /Users/sean/Library/Python/2.7/lib/python/site-packages/homebrew.pth
	sudo brew install pyqt
	./tools/build_ui.sh'
]

{ #category : #'as yet unclassified' }
CwAnki >> website [
	^ 'http://ankisrs.net' asUrl
]
