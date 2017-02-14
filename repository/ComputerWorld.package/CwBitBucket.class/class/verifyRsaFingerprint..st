as yet unclassified
verifyRsaFingerprint: aString
	"See https://confluence.atlassian.com/bitbucket/use-the-ssh-protocol-with-bitbucket-221449711.html"

	| fingerprints |
	fingerprints := #(
		'SHA256:zzXQOXSRBEiUtuE8AikJYKwbHaxvSc0ojez9YXaGp1A'
		'SHA256:RezPkAnH1sowiJM0NQXH90IohWdzHc3fAisEp7L3O3o'
		'97:8c:1b:f2:6f:14:6b:5c:3b:ec:aa:46:46:74:7c:40' 
		'35:ee:d7:b8:ef:d7:79:e2:c6:43:9e:ab:40:6f:50:74' ).
	
	self assert: (fingerprints includes: aString)