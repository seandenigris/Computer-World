actions
isExcluded: file
	"From: http://www.macworld.com/article/2033804/control-time-machine-from-the-command-line.html"
	^ 'tmutil isexcluded' asSuCommand, file