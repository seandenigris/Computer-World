as yet unclassified
restoreSafeMetadataTo: file

	| command exitCode backupFile commandTemplate |
	backupFile := file parent / file base, (file extension, '_original').
	commandTemplate := 'exiftool -overwrite_original -tagsfromfile "{1}" -exposuretime -aperturevalue -flash -iso -lens -focallength -orientation -datetimeoriginal "{2}"'.
	command := commandTemplate format: { backupFile fullName. file fullName }.
	exitCode := NBMacShell run: command.
	exitCode = 0 ifFalse: [ self error: 'exiftool failed to restore metadata' ].