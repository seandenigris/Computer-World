"
Find more topics in the Lepiter Docs. We would like to link to them from here, but Lepiter remote references do not seem to be supported in class comments ([asked on Discord](https://discord.com/channels/729445214812504107/755319168504692778/1177780007918125066))

# Application Control
See {{gtClass:CwMacApplication}}.
# Audio Output Control
[audiodevice](http://whoshacks.blogspot.com/2009/01/change-audio-devices-via-shell-script.html) seems intriguing, but it's canonical download point is on an individual's blog. It is recommended on several threads including [here](https://apple.stackexchange.com/a/213047/9507) on SO. [Here](https://github.com/gerardmassey/audiodevice) is a mirror repo on GH.
#Backups
The canonical ways to back up a Mac seem to be iCloud and/or {{gtClass:CwTimeMachine|label=Time Machine}}. The complexity of Mac's disk format, while perhaps justifiable from other standpoints e.g. security, make more standard (i.e. non-proprietary) methods a challenge. 

For example, {{gtClass:SuRSync|label=rsync}} is the go-to power user backup tool. Since NAS devices have been gaining popularity, one might think that backing up to a NAS via {{gtClass:SuRSync|label=rsync}} would be a great approach... Not so fast. One may quickly find out that Mac's ACLs and extended attributes are non supported by the NAS disk format (e.g. ext4). Rsync could probably be used to back up ""common"" documents (e.g. excluding proprietary Apple libraries like iTunes, Photos). See [this SO thread](https://apple.stackexchange.com/questions/425268/which-files-should-be-excluded-in-an-rsync-backup-with-macos-big-sur-version) for more details.

There is also Mac's own Disk Utility, which should be able to clone a volume via its ""Restore"" feature. However, one may encounter an inexplicable error, like `seal broken`.

So what are we to do?

The best bet for NAS seems to be {{gtClass:CwTimeMachine|label=Time Machine}}, which is officially supprted e.g. by {{gtClass:CwQnapNAS|label=QNAP}}. Note, however that not everyone has had a smooth ride with this. One could still also  {{gtClass:SuRSync|label=rsync}} to a NAS, but there are likely to be many errors. Thus it may have value as a seconary strategy, but might be best not to rely on.

{{gtClass:SuRSync|label=rsync}} does, however, seem to be better supported on Mac disk formats like HFS+ and APFS, which might be a better target, but being outside the officially Apple-supported methods, might still be best as a secondary strategy.

So where does that leave us? 

Here is a possible plan:
1. Time machine on NAS (or two) as primary backup
2. External HFS+/APFS disk via rsync as secondary

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
CwMac >> applicationFileTypeMap [
	^ SuGenericUnixCommand new
		template: '/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -dump';
		output
		
	"Reference: https://apple.stackexchange.com/a/276414"
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
CwMac >> defaultTextEditor: aString [
	"aString - desired app e.g. com.vim.macvim, com.sublimetext.3, or com.microsoft.VSCode
	
	Requires a restart to take effect"

	SuGenericUnixCommand new
		template: 'defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add ''\{LSHandlerContentType=public.plain-text;LSHandlerRoleAll={app};\}''';
		argumentAt: #app put: aString;
		run.
		
	"Adapted from several answers on https://apple.stackexchange.com/q/123833"
]

{ #category : #accessing }
CwMac >> dock [
	^ CwMacDock new
]

{ #category : #accessing }
CwMac >> hostname [

	^ 'hostname' asSuCommand output
	"There is also scutil on Mac that can get/set variations of host name"
]

{ #category : #accessing }
CwMac >> logoutCommandFor: username [

	^ SuGenericUnixCommand new
		template: 'launchctl bootout user/$(id -u {username})';
		argumentAt: #username put: username;
		asRoot;
		yourself.
		
	"Adapted from https://apple.stackexchange.com/a/230972"
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
