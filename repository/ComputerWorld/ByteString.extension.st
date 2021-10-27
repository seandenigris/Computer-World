Extension { #name : #ByteString }

{ #category : #'*ComputerWorld' }
ByteString >> asCwIPAddress [
	^ CwIPAddress fromString: self
]
