private
moveFileToApplicationsFolder

	| commandTemplate sourceFolder sourceFile |
	sourceFolder := FileLocator home / 'Downloads'.
	sourceFile := sourceFolder / '1Password.app'.
	commandTemplate := 'mv "{1}" /Applications'.
	"OSProcess command: (commandTemplate format: { sourceFile fullName })."