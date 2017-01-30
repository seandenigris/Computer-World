actions
tellGUITo: applescriptCommand

	| scriptTemplate script |
	scriptTemplate := '
		tell application "{1}" to activate
		tell application "System Events"
			tell process "{1}"
				{2}
			end tell
		end tell'.
	script := scriptTemplate format: { self applicationName. applescriptCommand }.
	^ Applescript doIt: script.