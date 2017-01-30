accessing
all
	"Another possibility would be to use the secure web form at https://db.debian.org/search.cgi"

	| soup keyContainer keysString lineEnding headerLine fingerprintLine email ownerName ownerLine lastLine key length id creationDate |
	soup := Soup fromUrl: 'https://www.debian.org/CD/verify'.
	keyContainer := soup findTag: 'pre'.
	keysString := keyContainer string trimBoth.
	lineEnding := Character lf asParser.
	length := $/ asParser negate plus flatten.
	id := #space asParser negate plus flatten.
	creationDate := lineEnding negate plus flatten.
	headerLine := 'pub' asParser, Character space asParser plus, length, $/ asParser, id, #space asParser, creationDate, lineEnding ==> [ :nodes |
		{ nodes third. nodes fifth. nodes seventh } ].
	fingerprintLine := Character space asParser plus, 'Key fingerprint = ' asParser, lineEnding negate plus flatten, lineEnding ==> #third.
	email := '&lt;' asParser, '&gt;' asParser negate plus flatten, '&gt;' asParser ==> #second.
	ownerName := email negate plus flatten.
	ownerLine := 'uid' asParser, #space asParser plus, ownerName, email, lineEnding ==> [ :nodes | { nodes third trimRight. nodes fourth } ].
	lastLine := lineEnding negate plus, lineEnding.
	key := headerLine, fingerprintLine, ownerLine, lastLine optional ==> [ :nodes |
			CwDebianKey new
				"length: nodes first first;
				creationDate: nodes first third"
				id: nodes first second;
				fingerprint: nodes second;
				yourself ].
	^ (key, lineEnding ==> #first) plus parse: keysString.