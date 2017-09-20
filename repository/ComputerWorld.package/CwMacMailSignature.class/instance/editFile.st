accessing
editFile
	self unlock.
	self file open.
	UIManager default alert: 'Done editing?'.
	self lock.