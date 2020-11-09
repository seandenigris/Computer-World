Class {
	#name : #CwLauncherTemplate,
	#superclass : #RlZipArchive,
	#instVars : [
		'isDeprecated'
	],
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwLauncherTemplate class >> allActive [
	^ self folder allFiles select: [ :f | self isClassFor: f ] thenCollect: [ :f | self on: f ]
]

{ #category : #accessing }
CwLauncherTemplate class >> folder [
	^ FileLocator preferences / 'pharo' / 'templateCache'
]

{ #category : #testing }
CwLauncherTemplate class >> isClassFor: file [
	^ (super isClassFor: file) and: [ file parent asFileReference = self folder asFileReference ]
]

{ #category : #accessing }
CwLauncherTemplate >> isDeprecated [
	^ self maLazyFrom: self isDeprecatedDescription
]

{ #category : #accessing }
CwLauncherTemplate >> isDeprecated: aBoolean [
	isDeprecated := aBoolean.
	self moveFileInto: self file parent / 'Deprecated'
]

{ #category : #'magritte-accessing' }
CwLauncherTemplate >> isDeprecatedDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isDeprecated;
		default: false;
		yourself
]
