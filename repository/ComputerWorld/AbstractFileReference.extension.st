Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld' }
AbstractFileReference >> compareDirectoryTo: rhs [
	"Reference: http://osxdaily.com/2010/07/12/compare-two-directories-contents-on-your-mac-using-diff/"

	^ 'diff -rq ', self fullName surroundedByDoubleQuotes, ' ', rhs fullName surroundedByDoubleQuotes
]

{ #category : #'*ComputerWorld' }
AbstractFileReference >> unquarantine [

	Smalltalk tools shell run: 'sudo xattr -r -d com.apple.quarantine ', self fullName surroundedByDoubleQuotes
	
	"Reference: https://apple.stackexchange.com/questions/243687/allow-applications-downloaded-from-anywhere-in-macos-sierra"
]
