as yet unclassified
signatureFolder

	| libraryMailFolder vFolders |
	libraryMailFolder := FileLocator home / 'Library' / 'Mail'.
	vFolders := libraryMailFolder directoriesMatching: 'V*'.
	self assert: vFolders size = 1. "Domain assumption"
	^ vFolders first / 'MailData' / 'Signatures'