as yet unclassified
installGuestAdditionsLinuxServer
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