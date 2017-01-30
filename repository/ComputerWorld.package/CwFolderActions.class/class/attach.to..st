private
attach: handlerScriptFile to: monitoredFile
	"Both arguments are FileReference instances"

	| attachScriptTemplate attachScriptSource |
	self ensureEnabled.
	attachScriptTemplate := 'set target_folder to POSIX file "{1}"
set script_file to POSIX file "{2}"

tell application "System Events"
	attach action to target_folder as alias using script_file as string
end tell'.
	attachScriptSource := attachScriptTemplate format: { monitoredFile. handlerScriptFile fullName }.
	Applescript doIt: attachScriptSource.