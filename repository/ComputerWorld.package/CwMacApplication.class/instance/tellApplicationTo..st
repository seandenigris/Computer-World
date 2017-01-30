actions
tellApplicationTo: applescriptCommand

	| scriptTemplate script isList |
	scriptTemplate := '
		tell application "{1}"
			{2}
		end tell'.
	script := scriptTemplate format: { self applicationName. applescriptCommand }.
	^ Applescript doIt: script.