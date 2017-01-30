as yet unclassified
install
	"Use Homebrew because suggested install method is via Sourceforge and from unidentified developer"
	<script>

	| installCommand scriptSafeUnixCommand scriptTemplate script command |
	installCommand := 'brew install git'.
	scriptSafeUnixCommand := installCommand copyReplaceAll: '"' with: '\"'.
	scriptTemplate := 'tell application "Terminal"
	do script "{installCommand}"
	activate
end tell'.
	script := scriptTemplate format: { #installCommand -> scriptSafeUnixCommand } asDictionary.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.