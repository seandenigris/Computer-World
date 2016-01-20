documentation
verifyDownload

	| commandTemplate command  exitCode keyFile download |
	keyFile := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip.asc'.
	download := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip'.
	commandTemplate := 'gpg --verify "{1}" "{2}"'.
	command := commandTemplate format: { keyFile fullName. download fullName }.
	exitCode := NBMacShell run: command.
	exitCode = 0
		ifTrue: [ UIManager default inform: 'Tor download is valid :)' ]
		ifFalse: [ self error: 'There is a problem with the pgp signature of the Tor download' ].