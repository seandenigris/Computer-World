as yet unclassified
testDownloadingOnPageLoad
	"When 1Password's download link is clicked, a page is loaded, and the file is simultaneously downloaded (I guess via JS). So we need to open the page in a browser to start the file downloading"

	| cw software |
	cw := ComputerWorld new.
	software := cw softwareNamed: '1Password'.
"	software downloadByOpening: 'http://agilebits.com/downloads/1Password/Mac' asUrl."
	self flag: #pending.