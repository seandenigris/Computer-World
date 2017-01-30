as yet unclassified
addToKeychain
	"Passphrase must be entered in Terminal to complete the operation
	Adapted from https://wiki.hpcc.msu.edu/display/hpccdocs/Adding+a+Private+Key+to+Your+Mac+OSX+Keychain"
	| command scriptTemplate script wrappedCommand |
	UIManager confirm: 'Drag private key into ~/.ssh'.
	
	command := 'ssh-add -K ~/.ssh/id_rsa'.
	scriptTemplate := 'tell application "Terminal"
	do script "{command}"
	activate
end tell'.
	script := scriptTemplate format: { #command -> command } asDictionary.
	wrappedCommand := 'osascript -e ''', script, ''''.
	LibC system: wrappedCommand.
	