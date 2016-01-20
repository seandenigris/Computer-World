as yet unclassified
loadLoginKeychainFromHomeFolder: fileReference
	"If you have your old disk mounted, supply the url to its home folder. Assumes same account name on new computer"

	| oldKeychainDirectory oldKeychainFile |
	oldKeychainDirectory := fileReference / 'Library/Keychains/'.
	oldKeychainFile := oldKeychainDirectory / 'login.keychain'.
	NBMacShell open: oldKeychainFile fullName.