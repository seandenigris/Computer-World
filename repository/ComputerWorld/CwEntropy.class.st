Class {
	#name : #CwEntropy,
	#superclass : #Object,
	#instVars : [
		'bits',
		'vulnerability',
		'equivalent'
	],
	#category : #'ComputerWorld-Security'
}

{ #category : #'as yet unclassified' }
CwEntropy class >> examples [
	"From http://world.std.com/~reinhold/dicewarefaq.html 'How long should my passphrase be?'"
	<sampleInstance>
	| data |
	data := #(
		(51.6 'Breakable in less than a day with two dozen graphics processors' '?')
		(64.6	'Breakable with a thousand or so PCs equipped with high-end graphics processors. (Criminal gangs with botnets of infected PCs can marshal such resources.)' 'You would be content to keep paper copies of the encrypted documents you are protecting in an ordinary desk or filing cabinet in an un-secured office.')
		(77.5	'May be breakable by an organization with a very large budget, such as a large country''s security agency.' 'You need or want strong security, but take no special precautions to protect your computer from unauthorized physical access, beyond locking the front door of your house or office.
			
Note: Should be the minimum on systems that use the passphrase directly to form a transmission or encryption key. Such systems include Hushmail, password managers, full disk encryption (e.g. Apple''s FileVault), Ciphersaber, and WiFi''s WPA.')
		(90.4	'Unbreakable with any known technology, but may be within the range of large organizations by around 2030.''s security agency.' 'TL;DR: If you are worried about an organization that can break a seven word passphrase in order to read your e-mail, there are a number of other issues you should be concerned with -- such as how well you pay the team of armed guards that are protecting your computer 24 hours a day.
			
Your computer is protected from unauthorized access at all times when not in your personal possession by being locked in a room or cabinet in a building where access is controlled 24 hours a day or that is protected by a high quality alarm service.
Routine cleaning and building maintenance people do not have physical access to your computer when you are not present.
You regularly use an up-to-date anti-virus program purchased off the floor at a computer store.
You have verified the signatures on your copy of PGP or GPG, etc.
You never run unverified downloaded software, e-mail attachments or unsolicited disks received through the mail on your computer.

Note: However I do encourage this as the minimum on high value systems that store money directly, such as BitCoin and other cryptocurrencies. I do not claim to be an expert on BitCoin, but some Internet searching suggests that many BitCoin wallets do very little key stretching. That and the fact that wallets are often used to store large sums of money, make them a very attractive target. I am not saying that a 7 word Diceware passphrase will make BitCoin safe, there are other risks to consider.')
	(103.3 'Should be completely secure through 2050' 'You take all the steps listed under less entropy, and:
Your computer is kept in a safe or vault at all times when it is not in sight of you or someone you trust.
Your computer was purchased off the floor at a randomly selected computer store.
All the software used on your computer was distributed with a strong, independently verified electronic signature that you checked, or was purchased off the floor in a randomly selected computer store
Your computer has never been repaired or upgraded by anyone you do not trust completely.
All disks and tapes used with your computer are either kept in a safe or physically destroyed.
You take precautions against audio and video surveillance when entering passphrases.
You change your PGP encryption key regularly (at least once a year).
You have taken precautions against TEMPEST attacks. See the chapter "Commonsense and Cryptography," in Internet Secrets, from IDG Books Worldwide, for a discussion of what this involves.')
	(116.3 'Long term data protection (greater than 10 years)' 'See previous')
	(129.2 'Matches the full 128-bit security that PGP, GPG or other encryption tools offer' 'See previous') ).
	^ data collect: [ :e |
			self new
				bits: e first;
				vulnerability: e second;
				equivalent: e third;
				yourself ]
]

{ #category : #'as yet unclassified' }
CwEntropy class >> lenstraEstimates [
	| html doc table |
	html := ZnClient new
		url: 'https://www.keylength.com/en/compare/' asUrl;
		formAt: 'symkey' put: 80 asString;
		formAt: 'methode' put: 'compare';
		post.
	doc := (XMLDOMParser on: html)
		isValidating: false;
		parseDocument.
	table := doc
		allElementsDetect: [ :e | 
			e name = #table
				and: [ e elements
						anySatisfy: [ :tr | tr elements first contentString = 'Method' ] ] ].
	^ table
]

{ #category : #accessing }
CwEntropy >> bits [
	^ self maLazyFrom: self bitsDescription
]

{ #category : #accessing }
CwEntropy >> bits: aNumber [
	bits := aNumber
]

{ #category : #'magritte-accessing' }
CwEntropy >> bitsDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #bits;
		yourself
]

{ #category : #accessing }
CwEntropy >> equivalent [
	^ equivalent ifNil: [ self examplesNotStronger last equivalent ]
]

{ #category : #accessing }
CwEntropy >> equivalent: anObject [
	equivalent := anObject
]

{ #category : #'magritte-accessing' }
CwEntropy >> equivalentDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #equivalent;
		beReadonly;
		yourself
]

{ #category : #accessing }
CwEntropy >> examplesNotStronger [ 
	^ self class examples select: [ :e | e bits <= self bits ].
]

{ #category : #printing }
CwEntropy >> printOn: aStream [

	aStream
		print: bits;
		nextPutAll: ' bits'
]

{ #category : #accessing }
CwEntropy >> vulnerability [
	^ vulnerability ifNil: [ self examplesNotStronger last vulnerability ]
]

{ #category : #accessing }
CwEntropy >> vulnerability: anObject [
	vulnerability := anObject
]

{ #category : #'magritte-accessing' }
CwEntropy >> vulnerabilityDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #vulnerability;
		beReadonly;
		yourself
]
