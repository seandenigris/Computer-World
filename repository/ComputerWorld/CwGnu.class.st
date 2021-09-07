Class {
	#name : #CwGnu,
	#superclass : #Object,
	#category : 'ComputerWorld-Apps'
}

{ #category : #'as yet unclassified' }
CwGnu class >> pgpPackage [

	^ CwGnuPg.
]

{ #category : #documentation }
CwGnu class >> url [

	^ 'https://gnu.org/software/gnupg/' asUrl.
]

{ #category : #'as yet unclassified' }
CwGnu >> gnuPg [
	"The GNU Privacy Guard (GnuPG) is a complete implementation of the OpenPGP Internet standard as described by RFC4880 (formerly RFC2440). It is used for digital encryption and signing of data and mainly useful for offline communication (email) and data storage. Version 2 also provides support for the S/MIME standard and includes an integrated implementation of the Secure Shell Agent"
	
	^ CwGnuPg new.
]
