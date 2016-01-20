instance creation
at: absolutePathString

	| path |
	path := Path from: absolutePathString.
	^ self fileSystem: FileSystem disk path: path.