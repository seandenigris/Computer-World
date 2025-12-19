Class {
	#name : 'CwExtendedAttributes',
	#superclass : 'Object',
	#instVars : [
		'file'
	],
	#category : 'ComputerWorld',
	#package : 'ComputerWorld'
}

{ #category : 'as yet unclassified' }
CwExtendedAttributes class >> for: aFileReference [ 
	^ self new
		file: aFileReference;
		yourself
]

{ #category : 'accessing' }
CwExtendedAttributes >> at: aString [

	^ SuGenericUnixCommand new
		template: 'xattr -p -x {attribute} {file}';
		argumentAt: #attribute put: aString;
		argumentAt: #file put: self file;
		outputDecoder: [ :str | self decode: str ];
		output
		
	"Adapted https://stackoverflow.com/a/70446742"
]

{ #category : 'accessing' }
CwExtendedAttributes >> decode: hexString [

	| isBinaryPlist hex |
	
	hexString ifEmpty: [ ^ nil ].
	
	hex := ByteArray readHexFrom: (hexString select: #isAlphaNumeric).
	
	isBinaryPlist := (hex first: 6) asString = 'bplist'. "per https://medium.com/@karaiskc/understanding-apples-binary-property-list-format-281e6da00dbd"
	
	isBinaryPlist ifFalse: [ ^ hex asString ].
	
	Tempfile do: [ :tf |
		tf binaryWriteStreamDo: [ :wstr | wstr nextPutAll: hex ].
		^ SuGenericUnixCommand new
			template: 'plutil -convert json -r -o - -- {inputFile}';
			argumentAt: #inputFile put: tf;
			outputDecoder: [ :str | STONJSON fromString: str ];
			output ]
		
	"Adapted from:
		- xattr part from https://stackoverflow.com/a/70446742
		- plutil gobbledygook from https://stackoverflow.com/a/33813384
		- xxd magic trick from https://scriptingosx.com/2017/08/parse-binary-property-lists-in-finder-metadata/"
]

{ #category : 'accessing' }
CwExtendedAttributes >> file [

	^ file
]

{ #category : 'accessing' }
CwExtendedAttributes >> file: anObject [

	file := anObject
]

{ #category : 'accessing' }
CwExtendedAttributes >> gtViewAllFor: aView [
	<gtView>
	
	^ aView columnedList
		title: 'List' translated;
		priority: 80;
		items: [ self list ];
		column: 'Name' 
			text: [ :e | e ]
			width: 250;
		column: 'Value' text: [ :e | self at: e ];
		send: [ :e | self at: e ]
]

{ #category : 'accessing' }
CwExtendedAttributes >> list [

	^ SuGenericUnixCommand new
		template: 'xattr {file}';
		argumentAt: #file put: self file;
		outputDecoder: #lines;
		output
]

{ #category : 'accessing' }
CwExtendedAttributes >> whereFroms [
	^ (self at: 'com.apple.metadata:kMDItemWhereFroms') ifNil: [ #() ]
]
