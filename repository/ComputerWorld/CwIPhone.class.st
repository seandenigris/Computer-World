"
# ""Backing Up"" Photos
Does it make sense to backup photos? In what circumstance do you want to make sure that you have exact snapshots of the photos on your device at particular times (the standard idea of backup)? I think what we typically want to do here is sync (in this case probably one way). So we want to copy all the photos on the phone to another folder if they are not already there
"
Class {
	#name : #CwIPhone,
	#superclass : #Object,
	#category : #'ComputerWorld-Core'
}

{ #category : #testing }
CwIPhone >> canBackUp [
	^ CwITunes iPhoneBackupFolder exists
]

{ #category : #accessing }
CwIPhone >> multimediaRootPath [
	"Contains multiple subfolders of the form ###APPLE (e.g. 103APPLE) with the actual photos and videos"
	^ Path from: 'Internal Storage/DCIM'
]
