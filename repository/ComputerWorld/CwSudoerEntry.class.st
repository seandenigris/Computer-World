Class {
	#name : #CwSudoerEntry,
	#superclass : #Object,
	#instVars : [
		'user',
		'host',
		'usesNames',
		'runAs'
	],
	#category : 'ComputerWorld-Unix'
}

{ #category : #example }
CwSudoerEntry class >> example [
	<sampleInstance>
	| user |
	user := SuUnixGroup new name: 'administrators'; yourself.
	^ CwSudoerEntry new
			user: user;
			yourself
]

{ #category : #accessing }
CwSudoerEntry >> host [
	^ self maLazyInstVarUsing: self hostDescription
]

{ #category : #accessing }
CwSudoerEntry >> host: aString [
	host := aString
]

{ #category : #'magritte-accessing' }
CwSudoerEntry >> hostDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #host;
		default: 'ALL';
		priority: 200;
		comment:
			'Host may be a hostname, IP address, or a whole network (e.g., 192.0.2.0/24), but not 127.0.0.1.';
		yourself
]

{ #category : #printing }
CwSudoerEntry >> printOn: aStream [

	aStream
		nextPutAll: self userString;
		space;
		nextPutAll: self host;
		nextPutAll: '=(';
		nextPutAll: self runAsString;
		nextPutAll: ') ALL'
]

{ #category : #accessing }
CwSudoerEntry >> runAs [
	^ self maLazyInstVarUsing: self runAsDescription
]

{ #category : #accessing }
CwSudoerEntry >> runAs: anObject [
	runAs := anObject
]

{ #category : #'magritte-accessing' }
CwSudoerEntry >> runAsDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #runAs;
		classes: SuUnixUserEntity subclasses;
		default: CwUnixNullUserEntity new;
		priority: 300;
		yourself
]

{ #category : #printing }
CwSudoerEntry >> runAsString [
	^ self stringForUserEntity: self runAs
]

{ #category : #printing }
CwSudoerEntry >> stringForUserEntity: aCwUnixUserEntity [
	^ self usesNames
			ifTrue: [ aCwUnixUserEntity sudoerNameString ]
			ifFalse: [ aCwUnixUserEntity sudoerIDString ]
]

{ #category : #accessing }
CwSudoerEntry >> user [
	^ self maLazyInstVarUsing: self userDescription
]

{ #category : #accessing }
CwSudoerEntry >> user: aString [
	user := aString
]

{ #category : #'magritte-accessing' }
CwSudoerEntry >> userDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #user;
		priority: 100;
		classes: SuUnixUserEntity subclasses;
		yourself
]

{ #category : #printing }
CwSudoerEntry >> userString [
	^ self stringForUserEntity: self user
]

{ #category : #accessing }
CwSudoerEntry >> usesNames [
	^ self maLazyInstVarUsing: self usesNamesDescription
]

{ #category : #accessing }
CwSudoerEntry >> usesNames: aBoolean [
	usesNames := aBoolean
]

{ #category : #'magritte-accessing' }
CwSudoerEntry >> usesNamesDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #usesNames;
		comment: 'Uses user and group names vs. [U|G]IDs';
		default: true;
		priority: 500;
		yourself
]
