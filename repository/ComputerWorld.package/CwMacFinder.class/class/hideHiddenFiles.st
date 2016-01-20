system settings
hideHiddenFiles

	self shell run: 'defaults write com.apple.finder AppleShowAllFiles 0 && killall Finder'