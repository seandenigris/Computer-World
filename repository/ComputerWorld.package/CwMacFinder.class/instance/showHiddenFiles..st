system settings
showHiddenFiles: aBoolean
	
	self restartAfterRunning: 'defaults write com.apple.finder AppleShowAllFiles -bool ', aBoolean asCwPlistString