accessing
tempFolder

	^ (FileLocator imageDirectory / 'tmp' / 'PDFtk') ensureDirectory.