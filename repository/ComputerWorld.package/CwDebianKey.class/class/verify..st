accessing
verify: checksumFile
	"Verify checksum file with the signature, and the signature against Debians keys. You must then use the keys in the checksum file to verify the iso. #inform: success or signal an error"

	| tmpFile signatureFile exitCode outputLines keyID fingerprint isTrustedKey |
	tmpFile := FileReference newTempfile.
	signatureFile := checksumFile, 'sign'.
	exitCode := NBMacShell run: 'gpg --verify "', signatureFile fullName, '" "', checksumFile fullName, '" > "', tmpFile fullName, '" 2>&1'.
	outputLines := tmpFile contents lines.
	keyID := outputLines first copyAfterLast: Character space.
	fingerprint := outputLines last allButFirst: 'Primary key fingerprint: ' size.
	isTrustedKey := self all anySatisfy: [ :e | e id = keyID and: [ e fingerprint = fingerprint ] ].
	tmpFile delete.
	(exitCode = 0 and: [ isTrustedKey ])
		ifTrue: [ UIManager inform: checksumFile basename, ' verified' ]
		ifFalse: [ self error: 'The signature of ', checksumFile basename, ' does not match ', 'https://www.debian.org/CD/verify' ]