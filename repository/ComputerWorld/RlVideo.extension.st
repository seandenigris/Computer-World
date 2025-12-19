Extension { #name : 'RlVideo' }

{ #category : '*ComputerWorld' }
RlVideo >> player [
	"In the future, one could imagine a sophisticated system, where each resource could specify its own default app, but for now we hard code QT"
	^ CwQuickTime reference
]
