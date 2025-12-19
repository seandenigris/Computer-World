Class {
	#name : 'CwGitClone',
	#superclass : 'Object',
	#instVars : [
		'location'
	],
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'accessing' }
CwGitClone >> commit: messageString [
	self 
		run: '{gitBinary} commit -m "{message}"' 
		with: { #message -> messageString }
]

{ #category : 'as yet unclassified' }
CwGitClone >> gitBinary [
	^ '/usr/bin/git' asFileReference
]

{ #category : 'accessing' }
CwGitClone >> location [
	^ self maLazyInstVarUsing: self locationDescription
]

{ #category : 'accessing' }
CwGitClone >> location: anObject [
	location := anObject
]

{ #category : 'accessing-magritte' }
CwGitClone >> locationDescription [
	<magritteDescription>
	^ MAFileDescription new
		accessor: #location;
		yourself
]

{ #category : 'as yet unclassified' }
CwGitClone >> move: sourceReference to: targetReference [
	self 
		run: '{gitBinary} mv "{sourceReference}" "{targetReference}"' 
		with: { #sourceReference -> sourceReference. #targetReference -> targetReference }
]

{ #category : 'accessing' }
CwGitClone >> push [
	self 
		run: '{gitBinary} push origin master' 
		with: { }
]

{ #category : 'as yet unclassified' }
CwGitClone >> run: template with: arguments [
	| command exitCode fullTemplate |
	fullTemplate := 'cd "{rootFolder}"; ', template.
	command := fullTemplate format: { #rootFolder -> self location fullName. #gitBinary -> self gitBinary fullName } asDictionary, arguments asDictionary.
	exitCode := LibC system: command.
	self assert: exitCode = 0
]

{ #category : 'as yet unclassified' }
CwGitClone >> stageAll [
	self 
		run: '{gitBinary} add -A' 
		with: { }
]
