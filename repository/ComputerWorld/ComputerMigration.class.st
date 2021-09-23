"
- Install Preferences - Manually install (copy) startup script and mcconfig file.
- Install Pharo Launcher. See https://github.com/seandenigris/Computer-World/wiki/Pharo-Launcher#installing-mac.
- Add Pharo to Dock. See CwPharo class.
- Install Adobe CC. See CwAdobeCreativeCloud class.
- Install Homebrew. See CwHomebrew class.
- Install Firefox. See CwFirefox class.
- Install SSH key. See CwSSH class.
- Install git. See CwGit class.
- Install Xcode. See CwXcode class.
"
Class {
	#name : 'ComputerMigration',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac'
}

{ #category : 'as yet unclassified' }
ComputerMigration class >> menuCommandOn: aBuilder [ 

	<worldMenu>
	(aBuilder item: #'Load Old Keychain')
		action:[ self new loadOldLoginKeychain. ].
]

{ #category : 'as yet unclassified' }
ComputerMigration class >> todo [
	"
	- Clone old mac drive - Carbon Copy Cloner?
	- Bash 
	- IRB
	- Jenkins
	- VIM"
]

{ #category : 'as yet unclassified' }
ComputerMigration >> loadLoginKeychainFromHomeFolder: fileReference [
	"If you have your old disk mounted, supply the url to its home folder. Assumes same account name on new computer"

	| oldKeychainDirectory oldKeychainFile |
	oldKeychainDirectory := fileReference / 'Library/Keychains/'.
	oldKeychainFile := oldKeychainDirectory / 'login.keychain'.
	NBMacShell open: oldKeychainFile fullName.
]
