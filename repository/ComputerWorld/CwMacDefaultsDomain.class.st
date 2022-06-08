Class {
	#name : #CwMacDefaultsDomain,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ComputerWorld-Mac'
}

{ #category : #accessing }
CwMacDefaultsDomain class >> all [

	| names |
	names :=  SuGenericUnixCommand new
	template: 'defaults domains';
	outputDecoder: [ :str | str splitOn: ', ' ];
	output.
	
	^ names collect: [ :e | self new name: e; yourself ]
]

{ #category : #accessing }
CwMacDefaultsDomain >> name [

	^ name
]

{ #category : #accessing }
CwMacDefaultsDomain >> name: anObject [

	name := anObject
]

{ #category : #accessing }
CwMacDefaultsDomain >> printOn: aStream [
	aStream
		nextPutAll: self name;
		nextPutAll: ' domain'
]

{ #category : #accessing }
CwMacDefaultsDomain >> read [

	| pyReadPList |
	pyReadPList := 'import nextstep_plist
nextstep_plist.loads(nspl)'.
	"Documentation: https://python-nextstep-plist.readthedocs.io/en/latest/readme.html"

	^ SuGenericUnixCommand new
		template: 'defaults read {name}';
		argumentAt: #name put: self name;
		outputDecoder: [ :nextStepPList |
			nextStepPList isEmpty 
				ifFalse: [
					PBApplication uniqueInstance 
						sendSource: pyReadPList
						withBindings: { #nspl -> nextStepPList } ]
				ifTrue: [ Dictionary new ] ];
		output.
		
	"Implementation note: this and two other options - reading preference files directly with `plutil` and accessing defaults directly those macOS libraries - are discussed at https://stackoverflow.com/questions/21511463/how-can-i-parse-the-output-of-defaults-read-on-os-x"
]
