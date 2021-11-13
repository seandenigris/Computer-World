"
# Application Control
See {{gtClass:CwMacApplication}}.
# Audio Output Control
[audiodevice](http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html) seems intriguing, but it's canonical download point is on an individual's blog. It is recommended on several threads including [here](https://apple.stackexchange.com/a/213047/9507) on SO. [Here](https://github.com/gerardmassey/audiodevice) is a mirror repo on GH.
# Command Line
<http://osxdaily.com/2006/11/22/ten-os-x-command-line-utilities-you-might-not-know-about/>
# Wi-Fi Control
Power can already easily be toggled with {{gtMethod:CwMac>>#wifiPower:}}:

For a comprehensive overview of what other actions might be available, see [here](https://www.techrepublic.com/article/pro-tip-manage-wi-fi-with-terminal-commands-on-os-x/).

"
Class {
	#name : #CwMac,
	#superclass : #Object,
	#category : #'ComputerWorld-Mac'
}

{ #category : #'instance creation' }
CwMac class >> current [
	^ self new
]

{ #category : #admin }
CwMac >> addSSHKeysToKeychain [
	CwSSH addKeysToKeychain
]

{ #category : #accessing }
CwMac >> defaultIPAddress [
	^ SuGenericUnixCommand new
		template: 'ipconfig getifaddr {deviceName}'; "via OSX Daily https://osxdaily.com/2010/08/08/lan-ip-address-mac/#comment-110377"
		argumentAt: #deviceName put: self defaultNetworkDeviceName;
		outputDecoder: [ :str | CwIPAddress fromString: str ];
		output
]

{ #category : #accessing }
CwMac >> defaultNetwork [
	^ CwIPAddressRange including: self defaultIPAddress subnetMask: self defaultSubnetMask
]

{ #category : #accessing }
CwMac >> defaultNetworkDeviceName [
	^ SuGenericUnixCommand new
		template: 'route -n get default|grep interface|awk ''\{ print $2 \}'''; "via OSX Daily https://osxdaily.com/2010/08/08/lan-ip-address-mac/#comment-110377"
		outputDecoder: [ :str | str trimBoth ];
		output
]

{ #category : #accessing }
CwMac >> defaultSubnetMask [
	^ SuGenericUnixCommand new
		template: 'ifconfig | grep -A 5 {deviceName}'; "via OSX Daily https://osxdaily.com/2010/08/08/lan-ip-address-mac/#comment-110377"
		argumentAt: #deviceName put: self defaultNetworkDeviceName;
		outputDecoder: [ :str | 
			| line tokens labelIndex hex0x raw |
			line := str lines detect: [ :l | l trimLeft beginsWith: 'inet ' ].
			tokens := line findTokens: ' '.
			labelIndex := tokens detectIndex: [ :e | e = 'netmask' ].
			hex0x := tokens at: labelIndex + 1.
			raw := Integer readFrom: (hex0x allButFirst: 2) base: 16.
			CwIPAddress fromInteger: raw ];
		output
]

{ #category : #accessing }
CwMac >> openFilesByProcess [
	SuGenericUnixCommand new
		template: 'sudo lsof -n +c 0 | cut -f1 -d'' '' | uniq -c | sort | tail';
		runInTerminal.
	"Adapted from https://superuser.com/a/1180084
		- `+c 0` prevents process name truncation
		- without sudo, it doesn't show all processes"
]

{ #category : #accessing }
CwMac >> openFilesLimit: aNumber [
	"More background, see https://wilsonmar.github.io/maximum-limits/"
	
	SuGenericUnixCommand new
		template: 'launchctl limit maxfiles {softLimit} unlimited';
		asRoot;
		argumentAt: #softLimit put: aNumber;
		run
]

{ #category : #accessing }
CwMac >> openFilesLimitExample [
	"<gtExample> Don't run automatically because requires interaction"
	self openFilesLimit: 1000
]

{ #category : #accessing }
CwMac >> privacyResetAutomationPermissions [
	"Useful if '{{Application}} wants to control {{Target}} popups not appearing"
	SuGenericUnixCommand new
		template: 'tccutil reset AppleEvents';
		run
]

{ #category : #user }
CwMac >> saveScreenshotsAs: extensionString [
	"
	aString - e.g. 'jpeg' 'png' 'pdf'
	
	Adapted from https://www.cultofmac.com/154406/save-mac-os-x-screenshots-as-something-besides-png-os-x-tips/"
	Smalltalk tools shell
		waitForCommand: 'defaults write com.apple.screencapture type ', extensionString;
		waitForCommand: 'killall SystemUIServer'
]

{ #category : #accessing }
CwMac >> setUpForSmalltalk [
	Su_ln new
		link: FileLocator dynabookData parent / 'preferences';
		target: FileLocator preferences / 'pharo';
		run
]

{ #category : #mounting }
CwMac >> smbMounter [
	^ SuSMBMount new
]

{ #category : #admin }
CwMac >> viewKernelPanicLogs [
	"From https://www.macobserver.com/tmo/article/os-x-troubleshooting-kernel-panics"
	Smalltalk tools shell new command: 'open /Library/Logs/DiagnosticReports/*.panic'
]

{ #category : #actions }
CwMac >> wifiPower: aBoolean [
	| statusString |
	statusString := aBoolean
		ifTrue: [ 'on' ]
		ifFalse: [ 'off' ].
	
	SuGenericUnixCommand new
		template: 'networksetup -setairportpower en0 {status}';
		argumentAt: #status put: statusString;
		run	
]
