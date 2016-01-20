documentation
verifyDownload

	| installer |
	installer := (FileLocator home / 'Downloads') files detect: [ :e | e basename matchesRegex: 'GPG Suite - .*\.dmg' ].
	Software assertShaFor: installer equals: self shaLatestVersion.