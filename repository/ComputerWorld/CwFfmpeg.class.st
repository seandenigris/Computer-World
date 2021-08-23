Class {
	#name : 'CwFfmpeg',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps'
}

{ #category : 'as yet unclassified' }
CwFfmpeg >> reencodeForQT [
	'ffmpeg -i input.mp4 -f mp4 -vcodec libx264 output.mp4'
]

{ #category : 'as yet unclassified' }
CwFfmpeg >> rotateVideo [
	"From https://stackoverflow.com/questions/3937387/rotating-videos-with-ffmpeg
	
	0 = 90CounterCLockwise and Vertical Flip (default)
1 = 90Clockwise
2 = 90CounterClockwise
3 = 90Clockwise and Vertical Flip

Use transpose=2,transpose=2 for 180 degrees."
	
	'ffmpeg -i in.mov -vf "transpose=1" out.mov'
]

{ #category : 'as yet unclassified' }
CwFfmpeg >> trim [
	"From https://stackoverflow.com/questions/18444194/cutting-the-videos-based-on-start-and-end-time-using-ffmpeg"
	
	'ffmpeg -i movie.mp4 -ss 00:00:03 -t 00:00:08 -async 1 cut.mp4
'
]
