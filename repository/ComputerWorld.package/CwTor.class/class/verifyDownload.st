documentation
verifyDownload

	| keyFile download |
	keyFile := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip.asc'.
	download := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip'.
	CwGpgTools new verify: download with: keyFile