as yet unclassified
testSetUpRepository
	
	Tempfile do: [ :tf |
		tf ensureCreateDirectory.
		CwTravisCI new setUp: tf.
		(tf / '.smalltalk.ston') exists should beTrue.
		(tf / '.travis.yml') exists should beTrue ].