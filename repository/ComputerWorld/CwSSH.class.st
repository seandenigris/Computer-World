Class {
	#name : #CwSSH,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwSSH class >> refreshKeychainSsh [
	"After upgrading MacOS, git was reporting no SSH credentials until I did this"
	<script>
	
	self run: 'ssh-add -K ~/.ssh/id_rsa'.

]

{ #category : #'as yet unclassified' }
CwSSH class >> run: command [
	Smalltalk tools shell new run: command
]

{ #category : #'as yet unclassified' }
CwSSH class >> useKeychainForSshPassphrases [
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

]

{ #category : #'as yet unclassified' }
CwSSH >> privateKeyFile [
	^ FileLocator home / '.ssh' / 'id_rsa'
]

{ #category : #'as yet unclassified' }
CwSSH >> setPrivateKeyPermissions [
	self class run: 'chmod 600 ', self privateKeyFile fullName
]
