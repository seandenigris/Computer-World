Class {
	#name : #CwPList,
	#superclass : #Object,
	#category : #'ComputerWorld-Core'
}

{ #category : #examples }
CwPList class >> exampleNeXTSTEPParser [
	<gtExample>
	^ self
		given: [ '{
    BackupPhase = Copying;
    ClientID = "com.apple.backupd";
    DateOfStateChange = "2022-01-05 17:32:43 +0000";
    DestinationID = "12345AB6-CD78-9E01-F23A-4B5CD6E7F8A9";
    DestinationMountPoint = "/Volumes/Backups of User\U2019s Laptop";
    EventFractionOfTotalProgressBar = "0.1";
    Progress =     {
        Percent = "0.05282568974538102";
        TimeRemaining = "7967.723014243437";
        "_raw_Percent" = "0.05282568974538102";
        "_raw_totalBytes" = 690289491968;
        bytes = 3197747200;
        files = 5034;
        sizingFreePreflight = 1;
        totalBytes = 690289491968;
        totalFiles = 2631745;
    };
    Running = 1;
    Stopping = 0;
}' ]
	when: [ :input | CwPList nextStepParser parse: input ]
	then: [ :output | 
		(output at: 'Running') should equal: 1 ]
]

{ #category : #accessing }
CwPList class >> nextStepParser [
	"Partial implementation of syntax from https://en.wikipedia.org/wiki/Property_list#NeXTSTEP"

	| quotedToken simpleToken token association dictionary value |
	quotedToken := $" asPParser, $" asPParser negate plus flatten, $" asPParser ==> #second.
	simpleToken := (#letter asPParser / #digit asPParser / (PP2PredicateObjectNode anyOf: '_$+/:.-')) plus flatten.
	token := quotedToken / simpleToken ==> [ :n |
		(NumberParser isNumber: n)
			ifFalse: [ n ]
			ifTrue: [ Number readFrom: n ] ].
	value := PP2UnresolvedNode new.
	association := token, #space asPParser plus, $= asPParser, #space asPParser plus, value, $; asPParser ==> [ :n | n first -> n fifth ].
	dictionary := ${ asPParser, #space asPParser plus, (association, #space asPParser plus ==> #first) plus, $} asPParser ==> [ :n |
		Dictionary newFrom: n third ].
	value def: token / dictionary.
	^ dictionary
]

{ #category : #'instance creation' }
CwPList class >> on: aFileReference [ 

	^ self new
		file: aFileReference;
		yourself.
]

{ #category : #'as yet unclassified' }
CwPList >> at: keySymbol [

	| tmpFile commandTemplate command output |
	tmpFile := ('tmp', DateAndTime now printString asValidSelector, '.txt') asFileReference.
	commandTemplate := 'defaults read "{1}" {2} > "{3}"'.
	command := commandTemplate format: { self file fullName. keySymbol. tmpFile fullName }.
	Smalltalk tools shell waitForCommand: command.
	output := tmpFile contents.
	tmpFile delete.
	^ output trimRight.
]

{ #category : #private }
CwPList >> file [
	^ file
]

{ #category : #private }
CwPList >> file: aFileReference [
	
	file := aFileReference.
]
