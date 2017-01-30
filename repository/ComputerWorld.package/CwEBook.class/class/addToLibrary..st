library (will be extracted from class)
addToLibrary: aDirectoryEntry

	| resourceFile book |
	resourceFile := Resources library import: aDirectoryEntry.
	book := CwEBook from: resourceFile.
	library add: book.