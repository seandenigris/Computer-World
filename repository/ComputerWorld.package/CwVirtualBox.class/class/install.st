installation
install
	<script>
	self notify: 'Can be installed via cask (has checksum or https'.
	Smalltalk tools webBrowser open: self downloadPage.
	