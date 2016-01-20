as yet unclassified
open

	| builder books content |
	builder := UITheme builder.
	books := EBook library collect: [ :b | b asMorph ].
	content := builder
		newColumn: { builder newRow: books }.
	(content openInWindowLabeled: 'Contacts') extent: 400 @ 500