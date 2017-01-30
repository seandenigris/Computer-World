documentation
verifyDownload

	| installer |
	installer := (FileLocator home / 'Downloads') files detect: [ :e | e basename matchesRegex: 'GPG Suite - .*\.dmg' ].
	CwSoftware assertShaFor: installer equals: self shaLatestVersion.