as yet unclassified
makeUsrLocalWritable
	"As of High Sierra, /usr/lib is no longer chown-able. The new procedure is:
	mkdir /usr/local/include
	sudo chown -R $(whoami) $(brew --prefix)/*
	
	From: https://github.com/Homebrew/brew/issues/3228"
	self shouldBeImplemented