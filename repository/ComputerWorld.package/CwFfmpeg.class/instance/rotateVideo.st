as yet unclassified
rotateVideo
	"From https://stackoverflow.com/questions/3937387/rotating-videos-with-ffmpeg
	
	0 = 90CounterCLockwise and Vertical Flip (default)
1 = 90Clockwise
2 = 90CounterClockwise
3 = 90Clockwise and Vertical Flip

Use transpose=2,transpose=2 for 180 degrees."
	
	'ffmpeg -i in.mov -vf "transpose=1" out.mov'