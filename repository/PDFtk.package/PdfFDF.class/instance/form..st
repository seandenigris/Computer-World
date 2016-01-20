private
form: aPdfForm 

	| contents |
	contents := PDFtk new
		generateFdfFor: aPdfForm;
		toStdOut;
		run.
	lines := contents lines.