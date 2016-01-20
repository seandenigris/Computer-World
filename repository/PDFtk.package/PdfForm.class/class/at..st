instance creation
at: stringOrFileReference

	^ self fileSystem: FileSystem disk path: stringOrFileReference asFileReference path.