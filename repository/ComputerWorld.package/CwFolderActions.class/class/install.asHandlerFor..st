private
install: aString asHandlerFor: aFileReference

	| handlerScriptFile handlerTemplate handlerSource |
	handlerScriptFile := FileLocator home / 'Library' / 'Scripts'/ 'Folder Action Scripts' / ('onFileAddedTo', aFileReference base), 'scpt'.
	handlerTemplate := 'on adding folder items to this_folder after receiving added_items
	{1}
end adding folder items to'.
	handlerSource := handlerTemplate format: { aString }.
	self compile: handlerSource to: handlerScriptFile.
	^ handlerScriptFile.