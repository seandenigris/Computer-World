Class {
	#name : #CwTravisCISpecification,
	#superclass : #BabyPhexample,
	#category : 'ComputerWorld-Specification'
}

{ #category : #'as yet unclassified' }
CwTravisCISpecification >> testBadge [
	| expected actual |
	expected := '[![Build Status](https://travis-ci.org/seandenigris/Pharo-Shell.png?branch=master)](https://travis-ci.org/seandenigris/Pharo-Shell)'.
	actual := CwTravisCI new badgeMarkupForProject: 'Pharo-Shell' byUser: 'seandenigris'.
	actual should equal: expected
]

{ #category : #'as yet unclassified' }
CwTravisCISpecification >> testSetUpMissingRepository [
	
	Tempfile do: [ :tf |
		[ CwTravisCI new setUp: tf ] should signal: Error ].
]

{ #category : #'as yet unclassified' }
CwTravisCISpecification >> testSetUpRepository [
	
	Tempfile do: [ :tf |
		tf ensureCreateDirectory.
		CwTravisCI new setUp: tf.
		(tf / '.smalltalk.ston') exists should beTrue.
		(tf / '.travis.yml') exists should beTrue ].
]
