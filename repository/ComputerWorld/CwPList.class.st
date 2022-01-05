Class {
	#name : #CwPList,
	#superclass : #Object,
	#category : 'ComputerWorld-Core'
}

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
		Dictionary newFromAssociations: n third ].
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
