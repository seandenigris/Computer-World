as yet unclassified
menuCommandOn: aBuilder 

	<worldMenu>
	(aBuilder item: #'Load Old Keychain')
		action:[ self new loadOldLoginKeychain. ].