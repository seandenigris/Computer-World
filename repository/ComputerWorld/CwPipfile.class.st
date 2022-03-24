Class {
	#name : #CwPipfile,
	#superclass : #RlResource,
	#instVars : [
		'sources',
		'devPackages',
		'packages',
		'requires',
		'lastUpdateTimestamp'
	],
	#category : #'ComputerWorld-Python'
}

{ #category : #testing }
CwPipfile class >> isClassFor: file [
	^ file basename = 'Pipfile'
]

{ #category : #accessing }
CwPipfile >> + rhs [
	
	^ self class new
		mergeIn: self;
		mergeIn: rhs;
		yourself.
]

{ #category : #accessing }
CwPipfile >> devPackages [
	self refresh.
	^ devPackages ifNil: [ devPackages := Dictionary new ]
]

{ #category : #accessing }
CwPipfile >> lastUpdateTimestamp [
	^ lastUpdateTimestamp ifNil: [ lastUpdateTimestamp := DateAndTime unixEpoch ]
]

{ #category : #accessing }
CwPipfile >> lastUpdateTimestamp: aDateAndTime [
	lastUpdateTimestamp := aDateAndTime
]

{ #category : #accessing }
CwPipfile >> mergeIn: rhs [
	
	rhs sources do: [ :rs | 
		(self sources includes: rs) ifFalse: [ self sources add: rs ] ].
	
	self devPackages addAll: rhs devPackages.
	
	self packages addAll: rhs packages.
		
	self mergeRequirementsFrom: { rhs }.
]

{ #category : #accessing }
CwPipfile >> mergeRequirementsFrom: aCollection [

	| candidates |
	candidates := aCollection 
		collect: #requirement 
		thenSelect: #isNotNil.
	candidates ifEmpty: [ ^ self ].
	self requires
		at: 'python_version' 
		put: candidates max printString
]

{ #category : #accessing }
CwPipfile >> packages [
	self refresh.
	^ packages ifNil: [ packages := Dictionary new ]
]

{ #category : #accessing }
CwPipfile >> refresh [
	self file ifNil: [ ^ self ].
	self file exists ifFalse: [ ^ self ].
	self file modificationTime > self lastUpdateTimestamp ifFalse: [ ^ self ].
	self lastUpdateTimestamp: DateAndTime now.
	[
		devPackages := nil.
		packages := nil.
		requires := nil.
		CwPipfileParser parseFile: self file to: self
	]
		on: Error 
		do: [ 
					"Could be in inconsistent state, so invalidate state "
					self lastUpdateTimestamp: DateAndTime unixEpoch ].
]

{ #category : #accessing }
CwPipfile >> requirement [
	^ self requires 
		ifNotEmpty: [ :reqs | 
			| tokens |
			tokens := (reqs atRandom value splitOn: $.) collect: #asInteger.
			CwPythonVersion 
				perform: #major:minor:patch:
				withEnoughArguments: tokens ] 
		ifEmpty: [ nil ].
]

{ #category : #accessing }
CwPipfile >> requires [
	self refresh.
	^ requires ifNil: [ requires := Dictionary new ]
]

{ #category : #accessing }
CwPipfile >> sources [
	self refresh.
	^ sources ifNil: [ sources := OrderedCollection new ]
]

{ #category : #accessing }
CwPipfile >> write [

	"Cache state before modifying file"
	
	| srcs devPkgs pkgs req |
	srcs := self sources.
	devPkgs := self devPackages.
	pkgs := self packages.
	req := self requirement.
	
	self file exists ifTrue: [ self file delete ].
	self file ensureCreateFile.
	
	self file writeStreamDo: [ :str |
	
		srcs do: [ :src |
			str << '[[source]]'.
			src keysAndValuesDo: [ :k :v |
				str lf.
				str
					print: k;
					nextPutAll: ' = ';
					print: v ].
			str lf; lf ].
			
		str << '[dev-packages]'.
		devPkgs keysAndValuesDo: [ :k :v |
			str lf.
			str << k << ' = '.
			str print: v ].
		str lf; lf.
			
		str << '[packages]'.
		pkgs keysAndValuesDo: [ :k :v |
			str lf.
			str << k << ' = '.
			str print: v ].
		str lf; lf.
		
		req ifNotNil: [	
			str << '[requires]'.
			str lf; << 'python_version = '; print: req dottedMajorMinor ] ].
]
