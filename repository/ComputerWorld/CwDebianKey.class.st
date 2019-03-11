"
self all.
self verify: 'SHA512SUMS' asFileReference.
"
Class {
	#name : #CwDebianKey,
	#superclass : #Object,
	#instVars : [
		'fingerprint',
		'id'
	],
	#category : 'ComputerWorld-Apps'
}

{ #category : #accessing }
CwDebianKey class >> all [
	"Another possibility would be to use the secure web form at https://db.debian.org/search.cgi"

	| soup keyContainer keysString lineEnding headerLine fingerprintLine email ownerName ownerLine lastLine key length id creationDate |
	soup := Soup fromUrl: 'https://www.debian.org/CD/verify'.
	keyContainer := soup findTag: 'pre'.
	keysString := keyContainer string trimBoth.
	lineEnding := Character lf asParser.
	length := $/ asParser negate plus flatten.
	id := #space asParser negate plus flatten.
	creationDate := lineEnding negate plus flatten.
	headerLine := 'pub' asParser, Character space asParser plus, length, $/ asParser, id, #space asParser, creationDate, lineEnding ==> [ :nodes |
		{ nodes third. nodes fifth. nodes seventh } ].
	fingerprintLine := Character space asParser plus, 'Key fingerprint = ' asParser, lineEnding negate plus flatten, lineEnding ==> #third.
	email := '&lt;' asParser, '&gt;' asParser negate plus flatten, '&gt;' asParser ==> #second.
	ownerName := email negate plus flatten.
	ownerLine := 'uid' asParser, #space asParser plus, ownerName, email, lineEnding ==> [ :nodes | { nodes third trimRight. nodes fourth } ].
	lastLine := lineEnding negate plus, lineEnding.
	key := headerLine, fingerprintLine, ownerLine, lastLine optional ==> [ :nodes |
			CwDebianKey new
				"length: nodes first first;
				creationDate: nodes first third"
				id: nodes first second;
				fingerprint: nodes second;
				yourself ].
	^ (key, lineEnding ==> #first) plus parse: keysString.
]

{ #category : #accessing }
CwDebianKey class >> verify: checksumFile [
	"Verify checksum file with the signature, and the signature against Debians keys. You must then use the keys in the checksum file to verify the iso. #inform: success or signal an error"

	| tmpFile signatureFile exitCode outputLines keyID fingerprint isTrustedKey |
	tmpFile := FileReference newTempfile.
	signatureFile := checksumFile, 'sign'.
	exitCode := NBMacShell run: 'gpg --verify "', signatureFile fullName, '" "', checksumFile fullName, '" > "', tmpFile fullName, '" 2>&1'.
	outputLines := tmpFile contents lines.
	keyID := outputLines first copyAfterLast: Character space.
	fingerprint := outputLines last allButFirst: 'Primary key fingerprint: ' size.
	isTrustedKey := self all anySatisfy: [ :e | e id = keyID and: [ e fingerprint = fingerprint ] ].
	tmpFile delete.
	(exitCode = 0 and: [ isTrustedKey ])
		ifTrue: [ UIManager inform: checksumFile basename, ' verified' ]
		ifFalse: [ self error: 'The signature of ', checksumFile basename, ' does not match ', 'https://www.debian.org/CD/verify' ]
]

{ #category : #accessing }
CwDebianKey >> fingerprint [
	^ fingerprint
]

{ #category : #private }
CwDebianKey >> fingerprint: aString [ 

	fingerprint := aString.
]

{ #category : #accessing }
CwDebianKey >> id [
	^ id
]

{ #category : #private }
CwDebianKey >> id: aString [ 

	id := aString.
]

{ #category : #printing }
CwDebianKey >> printOn: aStream [

	aStream
		nextPutAll: 'Debian key ';
		nextPutAll: id;
		nextPutAll: ' fingerprint = ', fingerprint.
]
