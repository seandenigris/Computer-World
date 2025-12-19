Class {
	#name : 'CwTravisCISpecification',
	#superclass : 'TestCase',
	#category : 'ComputerWorld-Specification',
	#package : 'ComputerWorld',
	#tag : 'Specification'
}

{ #category : 'as yet unclassified' }
CwTravisCISpecification >> testBadge [
	| expected actual |
	expected := '[![Build Status](https://travis-ci.org/seandenigris/Pharo-Shell.png?branch=master)](https://travis-ci.org/seandenigris/Pharo-Shell)'.
	actual := CwTravisCI new badgeMarkupForProject: 'Pharo-Shell' byUser: 'seandenigris'.
	actual should equal: expected
]

{ #category : 'as yet unclassified' }
CwTravisCISpecification >> testSetUpMissingRepository [
	
	Tempfile do: [ :tf |
		[ CwTravisCI new setUp: tf ] should raise: Error ].
]

{ #category : 'accessing' }
CwTravisCISpecification >> testSetUpRepository [
	
	Tempfile do: [ :tf |
		tf ensureCreateDirectory.
		CwTravisCI new setUp: tf.
		(tf / '.smalltalk.ston') should be exists.
		(tf / '.travis.yml') should be exists ].
]
