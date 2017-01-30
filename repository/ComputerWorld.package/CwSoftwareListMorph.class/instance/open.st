opening
open
	"self new open"

	| builder content |
	builder := UITheme builder.
	content := builder
		newColumn:
			{(builder
				newListFor: self
				list: #software
				selected: #contactSelectedIndex
				changeSelected: #contactSelectedIndex:
				help: 'Software').
			(builder
				newRow: {
					(builder
						newButtonFor: self
						action: #webPageButtonClick
						getEnabled: #hasSelectedContact
						label: 'Go to Web Page'
						help: 'Go to Web Page of currently selected software').
					(builder
						newButtonFor: self
						action: #downloadButtonClick
						getEnabled: #hasSelectedContact
						label: 'Download'
						help: 'Download current selection').
					(builder
						newButtonFor: self
						action: #installButtonClick
						getEnabled: #hasSelectedContact
						label: 'Install'
						help: 'Install current selection')})}.
	(content openInWindowLabeled: 'Contacts') extent: 400 @ 500