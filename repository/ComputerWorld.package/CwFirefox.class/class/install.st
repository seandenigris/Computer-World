as yet unclassified
install
	| dmgFile |
	self run: 'open ', 'https://www.mozilla.org/firefox/new/?scene=2'.
	self confirm: 'Click to continue when download is complete'.
	dmgFile := (FileLocator home / 'Downloads') filesMatching: 'Firefox *.dmg'.
	self run: 'open ', (dmgFile fullName surroundedBy: '"').
	'/Volumes/Firefox/Firefox.app' asFileReference copyTo: '/Applications/Firefox.app' asFileReference