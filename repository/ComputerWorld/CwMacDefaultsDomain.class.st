Class {
	#name : #CwMacDefaultsDomain,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'ComputerWorld-Core'
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
	^ SuGenericUnixCommand new
		template: 'defaults read {name}';
		argumentAt: #name put: self name;
		outputDecoder: [ :nextStepPList |
			nextStepPList isEmpty 
				ifFalse: [
					PBApplication uniqueInstance 
						sendSource: 'import nextstep_plist
nextstep_plist.loads(nspl)' 
						withBindings: { #nspl -> nextStepPList } ]
				ifTrue: [ Dictionary new ] ];
		output
]
