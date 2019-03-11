Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld' }
AbstractFileReference >> unquarantine [

	Smalltalk tools shell run: 'sudo xattr -r -d com.apple.quarantine ', self fullName surroundedByDoubleQuotes
	
	"Reference: https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra"
]
