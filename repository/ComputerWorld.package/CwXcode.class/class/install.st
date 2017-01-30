as yet unclassified
install
	<script>

	| script command |
	script := 'tell application "App Store" to activate'.
	command := 'osascript -e ''', script, ''''.
	LibC system: command.