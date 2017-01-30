actions
exclude: file
	"Sticky (i.e. follows moved files). Add -p flag for unsticky
	
	Motivation: Items such as scratch disks, backups, caches, and Lightroom previews should be excluded because they are unnecessary 
	
	Reference: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ ('tmutil addexclusion', file) asSuCommand asRoot