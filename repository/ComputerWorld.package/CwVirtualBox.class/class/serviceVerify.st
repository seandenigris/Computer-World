as yet unclassified
serviceVerify

	^ (SimpleServiceEntry 
		provider: self 
		label: 'Verify Checksum'
		selector: #verify:)
			argumentGetter: [ :fs | fs name asFileReference ];
			yourself