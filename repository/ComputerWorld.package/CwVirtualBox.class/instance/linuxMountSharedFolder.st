as yet unclassified
linuxMountSharedFolder
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