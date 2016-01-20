installing
install

	self hasBeenDownloaded ifFalse: [ self download ].
	self unzipDownloadedFile.