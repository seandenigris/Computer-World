documentation
verifyDownload
	| keyFilename keyFileUrl |
	keyFilename := self downloadFilename, '.sig'.
	keyFileUrl := self downloadSourceFolder / keyFilename.
	self download: keyFileUrl.
	CwGpgTools new
		verify: FileLocator home / 'Downloads' / self downloadFilename
		with: FileLocator home / 'Downloads' / keyFilename