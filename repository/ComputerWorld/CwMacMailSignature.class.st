Class {
	#name : #CwMacMailSignature,
	#superclass : #Object,
	#instVars : [
		'name',
		'id'
	],
	#category : 'ComputerWorld-Mac'
}

{ #category : #'instance creation' }
CwMacMailSignature class >> fromXML: aXMLElement [

	aXMLElement assert: (aXMLElement nodes at: 6) contentString = 'SignatureName'.
	aXMLElement assert: ((aXMLElement nodes at: 7) isKindOf: XMLString).
	aXMLElement assert: (aXMLElement nodes at: 10) contentString = 'SignatureUniqueId'.
	aXMLElement assert: ((aXMLElement nodes at: 11) isKindOf: XMLString).
	
	^ self new
			name: (aXMLElement nodes at: 8) contentString;
			id: (aXMLElement nodes at: 12) contentString;
			yourself
]

{ #category : #accessing }
CwMacMailSignature >> contents [
	"Strip headers"
	| contentLines |
	contentLines := self file contents lines copyAfter: ''.
	^ String streamContents: [ :s |
			contentLines
				do: [ :l | s nextPutAll: l ]
				separatedBy: [ s lf ] ]
]

{ #category : #accessing }
CwMacMailSignature >> editFile [
	self unlock.
	self file open.
	UIManager default alert: 'Done editing?'.
	self lock.
]

{ #category : #accessing }
CwMacMailSignature >> file [
	^ CwMacMail new signatureFolder / self id, 'mailsignature'
]

{ #category : #accessing }
CwMacMailSignature >> id [
	^ id
]

{ #category : #accessing }
CwMacMailSignature >> id: anObject [
	id := anObject
]

{ #category : #'actions api' }
CwMacMailSignature >> lock [
	self file macLock: true
]

{ #category : #accessing }
CwMacMailSignature >> name [
	^ name
]

{ #category : #accessing }
CwMacMailSignature >> name: anObject [
	name := anObject
]

{ #category : #printing }
CwMacMailSignature >> printOn: aStream [

	aStream
		nextPutAll: name;
		nextPutAll: ' mail sig (';
		nextPutAll: id;
		nextPut: $)
]

{ #category : #'actions api' }
CwMacMailSignature >> unlock [
	self file macLock: false
]

{ #category : #accessing }
CwMacMailSignature >> xmlContents [
	^ XMLDOMParser parse: self contents.
]
