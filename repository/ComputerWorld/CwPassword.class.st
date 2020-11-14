Class {
	#name : #CwPassword,
	#superclass : #Object,
	#instVars : [
		'possibilities',
		'length',
		'isPassphrase'
	],
	#classInstVars : [
		'dicewareWords'
	],
	#category : #'ComputerWorld-Security'
}

{ #category : #'as yet unclassified' }
CwPassword class >> dicewareWords [
	"The 'English list'. There are others, including https://theworld.com/%7Ereinhold/beale.wordlist.asc, edited by Alan Beale, which contains fewer Americanisms and obscure words"
	<sampleInstance>
	| response |
	dicewareWords ifNotNil: [ ^ dicewareWords ].
	response := ZnEasy get: 'https://theworld.com/%7Ereinhold/diceware.wordlist.asc'.
	dicewareWords := response contents lines
		select: [ :l | l matchesRegex: '\d\d\d\d\d	\S+'  ]
		thenCollect: [ :l | (l splitOn: Character tab) second ].
		
	"Verify list: As long as all the words are different, the list will provide full security. (per http://world.std.com/~reinhold/dicewarefaq.html)"
	self assert: dicewareWords asSet size = 7776.
]

{ #category : #'as yet unclassified' }
CwPassword class >> example10Alphabetical [
	<sampleInstance>

	^ CwPassword new
	possibilities: Character alphabet;
	length: 10;
	yourself.
	
]

{ #category : #'as yet unclassified' }
CwPassword class >> exampleDiceware [
	<sampleInstance>
	^ CwPassword new
			possibilities: self dicewareWords;
			yourself.
]

{ #category : #'accessing-entropy' }
CwPassword >> entropy [
	^ self entropyForLength: length
]

{ #category : #'accessing-entropy' }
CwPassword >> entropyBitsForLength: anInteger [
	"Reference: http://world.std.com/~reinhold/dicewarefaq.html"
	^ (anInteger * self entropyBitsPerCharacter) roundDownTo: 0.1.
]

{ #category : #'accessing-entropy' }
CwPassword >> entropyBitsPerCharacter [
	"Reference: http://world.std.com/~reinhold/dicewarefaq.html"
	^ self possibilities size log: 2
]

{ #category : #'accessing-entropy' }
CwPassword >> entropyForLength: anInteger [
	^ CwEntropy new
			bits: (self entropyBitsForLength: anInteger);
			yourself
]

{ #category : #'accessing-entropy' }
CwPassword >> entropyForLengthsFrom: start to: end [
	| result |
	result := Dictionary new.
	(start to: end) do: [ :i | 
			result at: i put: (self entropyForLength: i) ].
	^ result
]

{ #category : #accessing }
CwPassword >> isPassphrase [
	"Passphrases differ from passwords only in length. Passwords are usually short, six to ten characters. Short passwords are mostly OK for logging onto computer system that are programmed to detect multiple incorrect guesses and to protect the stored passwords properly, but they are not safe for use with encryption systems. Passphrases are usually much longer -- typically 25 to 64 characters (including spaces). Their greater length makes passphrases more secure. Modern passphrases were invented by Sigmund N. Porter in 1981. (from https://theworld.com/~reinhold/diceware.html)"
	^ self length >= 25
]

{ #category : #'magritte-accessing' }
CwPassword >> isPassphraseDescription [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: #isPassphrase;
		readOnly: true;
		yourself
]

{ #category : #accessing }
CwPassword >> length [
	^ self maLazyInstVarUsing: self lengthDescription
]

{ #category : #accessing }
CwPassword >> length: aNumber [
	length := aNumber
]

{ #category : #'magritte-accessing' }
CwPassword >> lengthDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #length;
		yourself
]

{ #category : #accessing }
CwPassword >> possibilities [
	^ self maLazyInstVarUsing: self possibilitiesDescription
]

{ #category : #accessing }
CwPassword >> possibilities: aCollection [
	possibilities := aCollection
]

{ #category : #'magritte-accessing' }
CwPassword >> possibilitiesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #possibilities;
		classes: { Character };
		yourself
]
