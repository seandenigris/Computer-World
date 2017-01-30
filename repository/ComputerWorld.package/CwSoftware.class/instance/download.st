downloading
download

	| commandTemplate |
	(FileDirectory on: self downloadPath) assureExistence.
	commandTemplate := 'cd "{1}" > /dev/null ; curl -O "{2}"'.
	OSProcess command: (commandTemplate format: { self downloadPath. downloadUrl }).