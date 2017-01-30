as yet unclassified
autoHideViaDefaults
	"We'll use Applescript instead, which doesn't require 'killing' the Dock"

	| commandTemplate command |
	commandTemplate := '/usr/bin/defaults write com.apple.Dock autohide -bool {flag}'. "Didn't work w/o bool flag; changed type to string"
	command := commandTemplate format: { #flag -> 'yes' } asDictionary.
	self restartAfterRunning: command