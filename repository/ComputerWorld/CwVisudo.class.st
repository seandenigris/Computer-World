Class {
	#name : 'CwVisudo',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwVisudo >> useVIM [
	^ 'export EDITOR=$(which vi)' asSuCommand
]
