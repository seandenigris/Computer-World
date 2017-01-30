actions
verify: file

	"sumsUrl := self secureUrl, 'SHA256SUMS'."
	| sumsFile |
	sumsFile := FileLocator home / 'Downloads' / 'SHA256SUMS'.
	(file verifySha256Equals: sumsFile).
	UIManager inform: file basename, ' verified'.