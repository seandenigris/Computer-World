as yet unclassified
magnification: factor
	"From https://www.tekrevue.com/tip/the-complete-guide-to-customizing-mac-os-xs-dock-with-terminal/"
	"Default = 128; Usual largest = 256"

	| largeSize command |
	largeSize := factor * 64.
	command := 'defaults write com.apple.dock largesize -float ' , largeSize asString.
	self restartAfterRunning: command