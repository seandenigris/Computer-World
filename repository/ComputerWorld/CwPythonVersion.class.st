Class {
	#name : 'CwPythonVersion',
	#superclass : 'SystemVersion',
	#category : 'ComputerWorld-Python',
	#package : 'ComputerWorld',
	#tag : 'Python'
}

{ #category : 'accessing' }
CwPythonVersion >> max: rhs [
	self major > rhs major ifTrue: [ ^ self ].
	self major < rhs major ifTrue: [ ^ rhs ].
	self minor ifNil: [ ^ rhs ].
	rhs minor ifNil: [ ^ self ].
	self minor > rhs minor ifTrue: [ ^ self ].
	self minor < rhs minor ifTrue: [ ^ rhs ].
	self patch ifNil: [ ^ rhs ].
	rhs patch ifNil: [ ^ self ].
	self patch > rhs patch ifTrue: [ ^ self ].
	self patch < rhs patch ifTrue: [ ^ rhs ].
	^ self
]

{ #category : 'accessing' }
CwPythonVersion >> printOn: aStream [

	aStream print: self major.
	self minor ifNotNil: [ 
		aStream
			nextPut: $.;
			print: self minor ].
	self patch ifNotNil: [ 
		aStream
			nextPut: $.;
			print: self patch ].
]
