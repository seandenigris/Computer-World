as yet unclassified
initialize

	super initialize.

	process := ProcessWrapper new.
	process
		useStdout;
		useStderr.