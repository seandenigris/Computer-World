"
# ""Backing Up"" Photos
Does it make sense to backup photos? In what circumstance do you want to make sure that you have exact snapshots of the photos on your device at particular times (the standard idea of backup)? I think what we typically want to do here is sync (in this case probably one way). So we want to copy all the photos on the phone to another folder if they are not already there

# Mounting as a Disk
[This superuser thread](https://superuser.com/a/1135668) seems promising. It's a testament to how far Apple has fallen from the Dynabook/PARC tree. Absurdly, this is natively possible *on Windoze*!
"
Class {
	#name : #CwIPhone,
	#superclass : #Object,
	#category : #'ComputerWorld-Core'
}

{ #category : #accessing }
CwIPhone class >> mountPoint [
	^ '/Volumes/Apple iPhone' asFileReference
]

{ #category : #testing }
CwIPhone >> canBackUp [
	^ CwITunes iPhoneBackupFolder exists
	
	"Implementation note: works even if the folder is remote (e.g. the default location is a link)"
]

{ #category : #accessing }
CwIPhone >> multimediaRootPath [
	"Contains multiple subfolders of the form ###APPLE (e.g. 103APPLE) with the actual photos and videos"
	^ Path from: 'Internal Storage/DCIM'
]
