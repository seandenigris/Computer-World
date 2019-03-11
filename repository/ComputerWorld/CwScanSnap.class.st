Class {
	#name : #CwScanSnap,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwScanSnap class >> install [
	"No secure download from Fujitsu [1], so Homebrew w. checksum seems to be best option 
	
	[1] https://www.fujitsu.com/global/support/products/computing/peripheral/scanners/scansnap/software/s1100m-setup.html"
	'brew cask install scansnap-manager-s1100'
]
