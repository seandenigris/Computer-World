Class {
	#name : #CwWordpress,
	#superclass : #Object,
	#category : #'ComputerWorld-Core'
}

{ #category : #tests }
CwWordpress >> testSpeed [

	Smalltalk tools webBrowser new open: 'https://www.blogtyrant.com/free-website-speed-test-tool/'
]
