as yet unclassified
autoHideDelay: aNumber
	| commandTemplate command |
	commandTemplate := 'defaults write com.apple.dock autohide-time-modifier -float {delay}'.
	command := commandTemplate format: {(#delay -> aNumber asString)} asDictionary.
	self restartAfterRunning: command