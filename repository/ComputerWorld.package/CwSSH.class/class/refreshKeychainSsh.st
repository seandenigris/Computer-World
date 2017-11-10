as yet unclassified
refreshKeychainSsh
	"After upgrading MacOS, git was reporting no SSH credentials until I did this"
	<script>
	
	self run: 'ssh-add -K ~/.ssh/id_rsa'.
