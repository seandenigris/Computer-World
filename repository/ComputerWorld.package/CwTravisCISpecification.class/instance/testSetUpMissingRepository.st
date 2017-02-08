as yet unclassified
testSetUpMissingRepository
	
	Tempfile do: [ :tf |
		[ CwTravisCI new setUp: tf ] should signal: Error ].