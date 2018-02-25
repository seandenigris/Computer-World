actions
verify: file
	| sumsFile filenameTokens version versionTokens majorMinor releaseUrl furtherInstructions |
	filenameTokens := file basenameWithoutExtension findTokens: '-'.
	self assert: filenameTokens first = 'ubuntu'.
	version := filenameTokens second.
	versionTokens := version findTokens: '.'.
	majorMinor := (versionTokens first: 2) joinUsing: $..
	"sumsUrl := self secureUrl, 'SHA256SUMS'."
	releaseUrl := 'http://releases.ubuntu.com/' asUrl / majorMinor.
	Smalltalk tools webBrowser open: releaseUrl.
	furtherInstructions := 'Instead of hosting the checksums on an encrypted page, you have to download them and check them against Ubuntu''s GPG keys. From https://help.ubuntu.com/community/VerifyIsoHowto:
gpg --verify SHA256SUMS.gpg SHA256SUMS
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys #({keyBinaryShort},...)
gpg --verify SHA256SUMS.gpg SHA256SUMS'.
	Smalltalk tools workspace openContents: furtherInstructions.
	self notify: 'The process got more complicated, and I don''t feel like updating at the moment.'.
	sumsFile := FileLocator home / 'Downloads' / 'SHA256SUMS'.
	(file verifySha256Equals: sumsFile).
	UIManager inform: file basename, ' verified'.