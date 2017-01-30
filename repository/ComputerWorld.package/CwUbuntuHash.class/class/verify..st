actions
verify: file

	"sumsUrl := self secureUrl, 'SHA256SUMS'."
	| sumsFile |
	self flag: 'The process got more complicated, and I don''t feel like updating at the moment. Instead of hosting the checksums on an encrypted page, you have to download them and check them against Ubuntu''s GPG keys. From https://help.ubuntu.com/community/VerifyIsoHowto:
gpg --verify SHA256SUMS.gpg SHA256SUMS
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 0xFBB75451
gpg --verify SHA256SUMS.gpg SHA256SUMS'.
	sumsFile := FileLocator home / 'Downloads' / 'SHA256SUMS'.
	(file verifySha256Equals: sumsFile).
	UIManager inform: file basename, ' verified'.