Class {
	#name : 'CwLaunchServices',
	#superclass : 'Object',
	#category : 'ComputerWorld-Mac',
	#package : 'ComputerWorld',
	#tag : 'Mac'
}

{ #category : 'accessing' }
CwLaunchServices >> openAll: file with: application [
	"Doesn't handle case where there is already an entry in the preferences plist"

	| preferencesFile |
	preferencesFile := FileLocator home / 'Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist'.

	^ SuGenericUnixCommand new
		template: 'defaults write {domain} LSHandlers -array-add ''\{ LSHandlerContentType = "{fileType}"; LSHandlerRoleAll = "{bundleIdentifier}"; \}''';
		argumentAt: #domain put: preferencesFile withoutExtension;
		argumentAt: #fileType put: file peMacContentType;
		argumentAt: #bundleIdentifier put: application bundleIdentifier;
		yourself
]
