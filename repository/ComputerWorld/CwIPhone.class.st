"
# ""Backing Up"" Photos/Videos
Does it make sense to backup photos? In what circumstance do you want to make sure that you have exact snapshots of the photos on your device at particular times (the standard idea of backup)? I think what we typically want to do here is sync (in this case probably one way). So we want to copy all the photos on the phone to another folder if they are not already there.

## Methods of getting media off phone
NB. The first thing you probably want to do is ensure the iPhone's photo transfer setting (Settings -> Photos -> Transfer to Mac or PC) is set to ""Keep originals"", *not* ""Automatic"". The latter [apparently](https://apple.stackexchange.com/a/331886) tries to convert the actual files on your iPhone (e.g. HEIC, AAE sidecar edit files) into something more useful, but can lead to problems. If this is set to ""Automatic"", the transfer speed may slow to a crawl and lead to arcane errors.

1. Image Capture on Mac - while the data corruption guarantee is unclear, the lack of complaints online seems to suggest it's not much of a problem. However, one big limitation is that the app will change the modification times of your files to the time of import. While this may not be a problem in many contexts, this is not universally true. For example, if a photo was used in a legal proceeding, would it suggest the photo could have been doctored?
2. Finder - there is a lot of chatter on the web that this method is *not* reliable
3. `rsync` - this method has potential and is free from the limitations of the options above, but the question is how to access the phone's filesystem. There are ways. For example, QNAP NAS boxes come with a driver, and there is apparently open source Mac software to do the same.

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
