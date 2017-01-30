accessing
all

	| soup hashRows |
	soup := Soup fromUrl: self secureUrl.
	hashRows := soup findAllTags: [ :e |
		'line862'.
		e name = 'tr' and: [ [ e td p hasClass: 'line862' ] on: Error do: [ false ] ] ].
	^ hashRows collect: [ :row | | cells |
		cells := row findAllChildTags: 'td'.
		CwUbuntuHash
			filename: cells second text trimBoth
			md5: cells first text trimBoth. ]