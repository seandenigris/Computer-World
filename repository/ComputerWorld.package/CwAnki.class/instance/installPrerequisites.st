as yet unclassified
installPrerequisites

	'sudo brew install sip
	mkdir -p ~/Library/Python/2.7/lib/python/site-packages
	echo ''import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")'' >> /Users/sean/Library/Python/2.7/lib/python/site-packages/homebrew.pth
	sudo brew install pyqt
	./tools/build_ui.sh'