Class {
	#name : #CwSSH,
	#superclass : #Object,
	#classVars : [
		'PrivateKeyFileName'
	],
	#category : #'ComputerWorld-Apps'
}

{ #category : #'key management' }
CwSSH class >> addKeysToKeychain [
	"Will not persist after reboot as of MacOS Sierra. Reference: http://apple.stackexchange.com/a/264974"
	self shell ensureSucceeds: 'ssh-add -K ', self privateKeyFile fullName surroundedByDoubleQuotes

]

{ #category : #'key management' }
CwSSH class >> privateKeyFile [
	^ FileLocator home / '.ssh' / self privateKeyFilename
]

{ #category : #'key management' }
CwSSH class >> privateKeyFilename [

	^ PrivateKeyFileName ifNil: [ 'id_rsa' ]
]

{ #category : #'key management' }
CwSSH class >> privateKeyFilename: aString [

	PrivateKeyFileName := aString
]

{ #category : #'key management' }
CwSSH class >> setPrivateKeyPermissions [
	self shell run: 'chmod 600 ', self privateKeyFile fullName surroundedByDoubleQuotes
]

{ #category : #private }
CwSSH class >> shell [
	^ Smalltalk tools shell new
]

{ #category : #'key management' }
CwSSH class >> useKeychainForPassphrases [
	"Persists after reboot. Required as of MacOS Sierra. Reference: https://developer.apple.com/library/archive/technotes/tn2449/_index.html and discussion at http://apple.stackexchange.com/a/264974"
	<script>
	
	| config |
	config := 'Host *
   UseKeychain yes
   AddKeysToAgent yes
   IdentityFile ', self privateKeyFile fullName surroundedByDoubleQuotes.
	Clipboard clipboardText: config.
	UIManager default confirm: 'Paste at end of config file...'.
	self shell run: 'open ~/.ssh/config'.

]
