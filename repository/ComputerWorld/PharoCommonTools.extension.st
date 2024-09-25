Extension { #name : #PharoCommonTools }

{ #category : #'*ComputerWorld' }
PharoCommonTools >> mailClient [

	^ self toolNamed: #mailClient
]

{ #category : #'*ComputerWorld' }
PharoCommonTools >> mailClient: aTool [

	self register: aTool as: #mailClient
]
