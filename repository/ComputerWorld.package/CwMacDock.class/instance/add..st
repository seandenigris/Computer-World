as yet unclassified
add: appBundle
	| commandTemplate command |
	commandTemplate := '/usr/bin/defaults write com.apple.dock persistent-apps -array-add ''<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>{appBundle}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'''.
	command := commandTemplate format: {(#appBundle -> appBundle fullName)} asDictionary.
	self restartAfterRunning: command