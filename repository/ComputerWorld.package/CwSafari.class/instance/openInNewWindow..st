opening
openInNewWindow: aUrl
	"Window will open in the current space on top of any others"

	| command |
	"Adapted from https://apple.stackexchange.com/a/141721/9507"
	command := 'activate
make new document with properties \{URL:"{1}"\}' format: { aUrl asString }.
	self applescriptTell: command