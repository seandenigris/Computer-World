private
applescriptTell: aString

	| command |
	"Adapted from https://apple.stackexchange.com/a/141721/9507. Didn't work without changing to Unix line endings, probably related to the HEREDOC"
	command := 'osascript <<EOD
tell application "Safari"
{1}
end tell
EOD' withUnixLineEndings format: { aString }.

	"Ideally this would not wait, but the implementation of OSShell #run: doesn't work with HEREDOCs"
	self shell runAndWait: command