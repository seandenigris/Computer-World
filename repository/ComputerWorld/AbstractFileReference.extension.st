Extension { #name : #AbstractFileReference }

{ #category : #'*ComputerWorld' }
AbstractFileReference >> compareDirectoryTo: rhs [
	"Reference: http://osxdaily.com/2010/07/12/compare-two-directories-contents-on-your-mac-using-diff/"

	^ 'diff -rq ', self fullName surroundedByDoubleQuotes, ' ', rhs fullName surroundedByDoubleQuotes
]
