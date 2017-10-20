as yet unclassified
applicationFolder: folder
	"Avoid permission errors when writing to /Applications (from https://github.com/caskroom/homebrew-cask/issues/27431#issuecomment-273127376)"
	
	self shouldBeImplemented.
	'export HOMEBREW_CASK_OPTS="--appdir=~/Applications"'