private
waitForFileToUnzip

	| downloadsFolder |
	downloadsFolder := (FileDirectory on: '/Users/god/Downloads').
	[ downloadsFolder includesKey: '1Password.app' ] whileFalse. 