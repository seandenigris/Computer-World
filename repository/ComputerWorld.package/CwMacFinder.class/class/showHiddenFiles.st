system settings
showHiddenFiles

	self shell run: 'defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'