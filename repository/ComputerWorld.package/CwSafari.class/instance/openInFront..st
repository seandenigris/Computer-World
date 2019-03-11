opening
openInFront: aUrl

	| command |
	command := 'activate
set the URL of the front document to "{1}"' format: { aUrl asString }.
	self applescriptTell: command.
	
	"Adapted from https://stackoverflow.com/a/7016686/424245"