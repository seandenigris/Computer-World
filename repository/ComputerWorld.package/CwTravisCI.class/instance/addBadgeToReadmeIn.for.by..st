as yet unclassified
addBadgeToReadmeIn: repositoryFolder for: projectName by: user 
	"It was tempting to retrieve the project name and user from the command line via `git remote get-url origin`, but at the moment doesn't seem worth the effort or dependency on a shell-support library"
	| reference originalContents |
	reference := repositoryFolder / 'README.md'.
	originalContents := reference ensureCreateFile contents.
	reference writeStreamDo: [ :str |
		str
			nextPutAll: (self badgeMarkupForProject: projectName byUser: user);
			crlf;
			nextPutAll: originalContents ]