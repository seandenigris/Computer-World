private
unzipDownloadedFile

	ZipArchive new
		readFrom: ((FileDirectory on: self downloadPath) matchingEntries: '*.zip') first fullName;
		extractAllTo: (FileDirectory on: self downloadPath).