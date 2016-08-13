as yet unclassified
deletePrinterNamed: aString
	"From http://smallbusiness.chron.com/delete-printer-command-line-mac-57868.html"

	| realPrinterName |
	realPrinterName := aString copyReplaceAll: ' ' with: '_'.
	LibC system: '/usr/sbin/lpadmin -x ', realPrinterName