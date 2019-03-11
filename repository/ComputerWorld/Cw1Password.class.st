"
cw := ComputerWorldDB data at: 1.
software := cw softwareNamed: '1Password'.
software downloadByOpening: 'http://agilebits.com/downloads/1Password/Mac' asUrl.

"
Class {
	#name : #Cw1Password,
	#superclass : #CwSoftware,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
Cw1Password class >> transferDataFileFrom: fullPathString [

	"# Create data file directory:
		sudo -u sean mkdir /Users/sean/Library/Application\ Support/1Password
		sudo chmod 770 /Users/sean/Library/Application\ Support/1Password
	# Copy data file
		sudo -u sean cp -fR ''/Volumes/Macintosh HD/Users/sean/Library/Application Support/1Password/1Password.agilekeychain' '/Users/sean/Library/Application Support/1Password/1Password.agilekeychain'
		sudo chmod 770 '/Users/sean/Library/Application Support/1Password/1Password.agilekeychain'"

]
