as yet unclassified
install
	<script>

	| installCommand scriptSafeUnixCommand scriptTemplate script command |
	installCommand := 'ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'.
	scriptSafeUnixCommand := installCommand copyReplaceAll: '"' with: '\"'.
	scriptTemplate := 'tell application "Terminal"
	do script "{installCommand}"
	activate
	end tell'.
	script := scriptTemplate format: { #installCommand -> scriptSafeUnixCommand } asDictionary.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.