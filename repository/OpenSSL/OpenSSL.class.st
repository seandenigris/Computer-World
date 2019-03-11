"
self new isVulnerableToHeartbleed.
"
Class {
	#name : #OpenSSL,
	#superclass : #Object,
	#category : 'OpenSSL'
}

{ #category : #'as yet unclassified' }
OpenSSL >> isVulnerableToHeartbleed [
	"https://www.openssl.org/news/secadv_20140407.txt"
	
	| tmpOutputFile lines |
	tmpOutputFile := FileLocator imageDirectory / 'osslversion.txt'.
	NBMacShell run: '/usr/local/Cellar/openssl/1.0.1g/bin/openssl version -a > "', tmpOutputFile fullName, '"'.
	lines := tmpOutputFile contents lines.
	^ (lines first beginsWith: 'OpenSSL 1.0.1') and: [ (lines first at: 14) ~= $g ].
	
]
