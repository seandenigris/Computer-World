as yet unclassified
menuCommandOn: aBuilder 

	<worldMenu>
	| pharoCastList |
	pharoCastList := aBuilder item: #'PharoCasts'.
	pharoCastList with: [
		self database do: [ :e | | openPharoCastItem |
			openPharoCastItem := aBuilder item: e title.
			openPharoCastItem
				action:[ e openInbrowser ]; 
				help: 'Open this PharoCast in the default browser' ] ].