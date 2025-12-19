Class {
	#name : 'CwTor',
	#superclass : 'Object',
	#category : 'ComputerWorld-Apps',
	#package : 'ComputerWorld',
	#tag : 'Apps'
}

{ #category : 'as yet unclassified' }
CwTor class >> currentPgpSignature [

	^ 'https://www.torproject.org/dist/torbrowser/3.5.3/TorBrowserBundle-3.5.3-osx32_en-US.zip.asc' asUrl retrieveContents.
]

{ #category : 'as yet unclassified' }
CwTor class >> defaultPortNumber [

	^ 9150.
]

{ #category : 'as yet unclassified' }
CwTor class >> download [

	ZnClient new
		url: 'https://www.torproject.org/dist/torbrowser/3.5.3/TorBrowserBundle-3.5.3-osx32_en-US.zip';
		downloadTo: FileLocator home / 'Downloads'.
]

{ #category : 'documentation' }
CwTor class >> multipleCircuits [
	"Per http://maymay.net/blog/2013/02/20/howto-use-tor-for-all-network-traffic-by-default-on-mac-os-x/"
	
	"If you’d like to be even harder to track, you can take the time to have Tor listen for connection requests on multiple different ports. Although you don’t have to do this, it’s a good idea because it means you can send network traffic along different routes (called “circuits”) inside the Tor network itself. This way, you might appear to be browsing the Web from France but checking your email from Canada at the same time, and an attacker would need to be watching both locations to have a shot at figuring out that both the Web and email traffic were coming from you. "
]

{ #category : 'documentation' }
CwTor class >> verifyDownload [

	| keyFile download |
	keyFile := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip.asc'.
	download := FileLocator home / 'Downloads/TorBrowserBundle-3.5.3-osx32_en-US.zip'.
	CwGpgTools new verify: download with: keyFile
]

{ #category : 'documentation' }
CwTor >> dependencies [
	"Gnu depends on ZnSpd"
]

{ #category : 'private' }
CwTor >> pList [

	^ CwPList on: '/Applications/TorBrowserBundle_en-US.app/Contents/Info.plist' asFileReference.
]

{ #category : 'as yet unclassified' }
CwTor >> version [

	^ self pList at: #CFBundleShortVersionString.
]
