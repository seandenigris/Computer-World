Class {
	#name : #CwLauncherTemplate,
	#superclass : #RlZipArchive,
	#instVars : [
		'isDeprecated'
	],
	#category : 'ComputerWorld-Mac'
}

{ #category : #'active-accessing' }
CwLauncherTemplate class >> allActive [
	| active |
	active := self folder allFiles select: [ :f | self isClassFor: f ] thenCollect: [ :f | self on: f ].
	^ active sort: [ :a :b | a file base < b file base ]
]

{ #category : #'active-accessing' }
CwLauncherTemplate class >> allActiveMatching: regexString [
	"Example: self allActiveMatching: '(GT |Le).*'"
	| relevant |
	relevant := self allActive select: [ :e | e file base matchesRegex: regexString ].
	^ relevant "sort: [ :a :b | a file base < b file base ]."
]

{ #category : #'active-accessing' }
CwLauncherTemplate class >> allActiveMissingFromRlLibrary [
	"This should be the same as #allActive because we're not currently storing active templates in the library"
	^ self allActive reject: [ :e | RlResourceLibrary uniqueInstance resources includes: e ]
]

{ #category : #accessing }
CwLauncherTemplate class >> folder [
	^ FileLocator preferences / 'pharo' / 'templateCache'
]

{ #category : #'gt-views' }
CwLauncherTemplate class >> gtActiveFor: aView [
	<gtClassView>
	^ aView list
		title: 'Active';
		items: self allActive;
		itemText: #displayString;
		yourself
]

{ #category : #testing }
CwLauncherTemplate class >> isClassFor: file [
	^ (super isClassFor: file) and: [ file parent asFileReference = self folder asFileReference ]
]

{ #category : #comparing }
CwLauncherTemplate >> = rhs [
	^ self class = rhs class and: [ self file basename = rhs file basename ]
]

{ #category : #accessing }
CwLauncherTemplate >> deprecate [
	"Motivation: keep currently unneeded templates from cluttering Launcher by moving them out of the template folder. Having them around makes it more awkard because e.g. one has to scroll down further and further in the template list."
	self isDeprecated: true.
	RlResourceLibrary uniqueInstance import: self
]

{ #category : #accessing }
CwLauncherTemplate >> displayStringOn: aStream [
	aStream nextPutAll: self file base
]

{ #category : #comparing }
CwLauncherTemplate >> hash [
	^ self file basename hash
]

{ #category : #accessing }
CwLauncherTemplate >> isDeprecated [
	^ self maLazyInstVarUsing: self isDeprecatedDescription
]

{ #category : #accessing }
CwLauncherTemplate >> isDeprecated: aBoolean [
	isDeprecated := aBoolean.
]

{ #category : #'magritte-accessing' }
CwLauncherTemplate >> isDeprecatedDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isDeprecated;
		default: false;
		yourself
]
