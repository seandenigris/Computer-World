private
downloadByOpening: aUrl

	urlDownloadsOnOpen := aUrl.
	timePageOpened := DateAndTime now.
	self openInBrowser: aUrl.
	self waitForFileToBeginDownloading.
	self closeTheBrowserWindow.
	self waitForFileToFinishDownloading.
	self waitForFileToUnzip.
	self moveFileToApplicationsFolder.