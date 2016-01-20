as yet unclassified
saveTo: file

	file writeStreamDo: [ :str | 
		str
			nextPutAll: PDFtkFdfFormat new header; lf;
			nextPutAll: (PDFtkFdfFormat new bodyWith: fields); lf;
			nextPutAll: PDFtkFdfFormat new trailer ].
