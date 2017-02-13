as yet unclassified
useKeychainForSshPassphrases
	"New method as of MacOS Sierra. Reference: http://apple.stackexchange.com/a/264974"
	<script>
	
	| config |
	config := 'Host *
   AddKeysToAgent yes
   UseKeychain yes
   IdentityFile ~/.ssh/id_rsa'.
	Clipboard clipboardText: config.
	UIManager default confirm: 'Paste at end of config file...'.
	self run: 'open ~/.ssh/config'.
