"
# Default Login Credentials
Depends on OS version. See [here](https://www.qnap.com/en/how-to/knowledge-base/article/default-password-of-admin-is-changed-to-first-mac-address-after-qts-4-4-2) for more info.

# iPhones and rsync
Trying to download all the photos and videos off an iPhone via rsync on a QNAP NAS seems terribly inconsistent (learned from repeated painful experience). So what are we really trying to do? There are several steps:
1. Get media safely off the phone. 
  - There is Mac's Image Capture, but there doesn't seem to be any info out there on how secure this option is (i.e. can you inadvertently and unknowingly lose data). Then, there's a question of whether to move to Mac first or straight to NAS. NAS would be nice obviously, but then rsync seems like like possibly the wrong tool because you need a straight mv.
  - There's QNAP's ability to mount the media as a USB. The problem here is that the files are not in flat folders, so some scripting will be needed
  
**Maybe do it however and then use rsync to verify?**
"
Class {
	#name : #CwQNAP,
	#superclass : #Object,
	#category : #'ComputerWorld-Networking'
}

{ #category : #accessing }
CwQNAP class >> downloadViaClippedUrlVerifyingMD5: aString [
	| url resource |
	self error: 'almost working except for two things: 1) must be unzipped before adding to library and 2) we should keep a record of available versions, although this perhaps could be reconstructed via the resource''s URL'.
	url := Clipboard clipboardText asString asUrl.
	url scheme = #https ifFalse: [ self error: 'insecure url' ].
	resource := url asRlResource.
	resource file md5 = aString ifFalse: [ self error: 'MD5 hash mismatch' ].
	^ "RlResourceLibrary uniqueInstance import:" resource.
]

{ #category : #accessing }
CwQNAP class >> downloadsForModel: aString [
	"CwQNAP downloadsForModel: 'tvs-472xt' >>> self"
	| url |
	url := 'https://www.qnap.com/en/download?category=firmware' asUrl
		queryAt: 'model' put: aString;
		yourself.
		
	Smalltalk tools webBrowser new open: url
]

{ #category : #accessing }
CwQNAP class >> qfinder [
	"Opens the download center and places the app name on the clipboard so you can paste it into the browser page search. You have to manually select 'Utilities' on the web page. It would be great to parse the result for programmatic access, but maybe not worth the effort. To that end, an example download link: https://us1.qnap.com/Storage/Utility/QNAPQfinderProMac-7.6.0.0913.dmg"

	| model |
	model := CwServer db 
		detect: [ :e | e manufacturer = 'QNAP' ]
		ifNone: [ CwQnapNAS exampleTS262 "Qfinder is generic, so the exact model doesn't seem to matter" ].
	 
	Clipboard clipboardText: 'Qfinder Pro'.
	model browseDownloadCenter
]
