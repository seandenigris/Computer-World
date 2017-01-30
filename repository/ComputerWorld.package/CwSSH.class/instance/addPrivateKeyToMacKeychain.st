as yet unclassified
addPrivateKeyToMacKeychain
	"From http://superuser.com/a/269570/84195"
	self run: 'ssh-add -k ', self privateKeyFile fullName