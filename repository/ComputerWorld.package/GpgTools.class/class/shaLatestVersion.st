documentation
shaLatestVersion

	| downloadPageSource shaLine matcher |
	downloadPageSource := 'https://gpgtools.org/gpgsuite.html' asUrl retrieveContents.
	shaLine := downloadPageSource lines detect: [ :e | e trimLeft beginsWith: '<p>SHA-1:' ].
	matcher := RxMatcher forString: '<p>SHA-1\: (\w+)</p>'.
	matcher search: shaLine trimBoth.
	^ matcher subexpression: 2