as yet unclassified
verify: file
	| filenameTokens version shaUrl |
	filenameTokens := file basenameWithoutExtension findTokens: '-'.
	version := filenameTokens second.
	shaUrl := 'https://www.virtualbox.org/download/hashes' asUrl / version / 'SHA256SUMS'.
	file verifySha256Equals: shaUrl.
	UIManager default inform: 'VirtualBox file verified.'