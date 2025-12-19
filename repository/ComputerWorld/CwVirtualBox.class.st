Class {
	#name : 'CwVirtualBox',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwVirtualBox class >> downloadPage [
	^ 'https://www.virtualbox.org/wiki/Downloads' asUrl
]

{ #category : 'as yet unclassified' }
CwVirtualBox class >> extPackDownloadFolder [
	"Filename is of the format Oracle_VM_VirtualBox_Extension_Pack-5.1.10.vbox-extpack"
	^ FileLocator home / 'Library' / 'VirtualBox'
]

{ #category : 'as yet unclassified' }
CwVirtualBox class >> fileReaderServicesForFile: fullName suffix: suffix [
	<fileService>

	^(#('vbox' 'vbox-extpack') includes: suffix)
		ifTrue: [ { self serviceVerify } ]
		ifFalse: [#()]

]

{ #category : 'installation' }
CwVirtualBox class >> install [
	<script>
	self notify: 'Can be installed via cask (has checksum or https)'.
	Smalltalk tools webBrowser open: self downloadPage.
	
]

{ #category : 'as yet unclassified' }
CwVirtualBox class >> installGuestAdditionsLinuxServer [
	"
	**** Failed with mounted guest image following a few different guides. WORKED via:
	1. Update VirtualBox
	2. `sudo apt-get install virtualbox-guest-dkms` (per https://superuser.com/a/1274192)
	
	FORGET THE FOLLOWING:
	Prerequisites: click Devices | Insert Guest Additions CD Image.
	#Mount the CD-ROM
	sudo mount /dev/cdrom /media/cdrom.

	cd /media/cdrom.

	#Install dependencies
	sudo apt-get install -y dkms build-essential linux-headers-generic linux-headers-$(uname -r)

	#Be root
	sudo su
	# Install Guest Additions
	./VBoxLinuxAdditions.run


	#NB. You will see an error stating that the installer couldn't find the X.Org or XFree86 Window System—that's okay, because it doesn't exist on this host.

	#Reboot your machine
	
	From: https://www.techrepublic.com/article/how-to-install-virtualbox-guest-additions-on-a-gui-less-ubuntu-server-host/
	
	**** Additional dependencies listed on https://virtualboxes.org/doc/installing-guest-additions-on-ubuntu/"
]

{ #category : 'as yet unclassified' }
CwVirtualBox class >> serviceVerify [

	^ (SimpleServiceEntry 
		provider: self 
		label: 'Verify Checksum'
		selector: #verify:)
			argumentGetter: [ :fs | fs name asFileReference ];
			yourself
]

{ #category : 'as yet unclassified' }
CwVirtualBox class >> verify: file [
	| filenameTokens version shaUrl |
	filenameTokens := file basenameWithoutExtension findTokens: '-'.
	version := filenameTokens second.
	shaUrl := 'https://www.virtualbox.org/download/hashes' asUrl / version / 'SHA256SUMS'.
	file verifySha256Equals: shaUrl.
	UIManager default inform: 'VirtualBox file verified.'
]

{ #category : 'as yet unclassified' }
CwVirtualBox >> linuxMountSharedFolder [
	"There is an auto-mount option that doesn't seem to work (as of 2/24/2018 w up-to-date VB and Ubuntu 16.04 LTS.
	To automount, append to /etc/fstab (via [3]):
		{shareName} {mountPoint} vboxsf uid=1000,gid=1000
	To do the same from the command line (via [2]):
		sudo mount -t vboxsf -o uid=1000,gid=1000  {shareName} {mountPoint}
	
	This 'worked' (via [1]), but root owned all the files. Append to /etc/fstab: 
		sharename   mountpoint   vboxsf   defaults  0   0
	
	1. https://www.virtualbox.org/manual/ch04.html#sf_mount_auto
	2. https://ubuntuforums.org/showthread.php?t=1398340
	3. https://askubuntu.com/a/123156"
]

{ #category : 'as yet unclassified' }
CwVirtualBox >> linuxVmSwapCmdAndCtrl [
	"
First, change the host key to a key other than Left Cmd (e.g. Right Cmd)

	Reference: https://askubuntu.com/questions/131900/how-do-i-switch-the-command-key-and-control-key-on-a-macbook-pro"
	
	"Put the following in ~/.Xmodmap:

clear control
clear mod4

keycode 133 = Control_L NoSymbol Control_L
keycode 134 = Control_R NoSymbol Control_R
keycode 37 = Super_L NoSymbol Super_L

add control = Control_L
add control = Control_R
add mod4 = Super_L

To test, run the command:

xmodmap ~/.Xmodmap

To make it run every time, add it to Startup Applications."
]
