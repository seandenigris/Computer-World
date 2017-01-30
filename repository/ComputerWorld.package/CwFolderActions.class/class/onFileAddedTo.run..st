API
onFileAddedTo: aFileReference run: aString 

	| handlerScriptFile |
	handlerScriptFile := self install: aString asHandlerFor: aFileReference.
	self attach: handlerScriptFile to: aFileReference.