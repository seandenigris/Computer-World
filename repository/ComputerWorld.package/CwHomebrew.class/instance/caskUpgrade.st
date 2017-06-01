as yet unclassified
caskUpgrade
	"
	- Must be run as administrator
	- Command from https://stackoverflow.com/questions/31968664/upgrade-all-the-casks-installed-via-homebrew-cask"

	Smalltalk tools shell runExternally: 'brew cask outdated | xargs brew cask reinstall'.