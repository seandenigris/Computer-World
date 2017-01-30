private-accessing
contactSelectedIndex: aNumber

	contactSelectedIndex := aNumber.
	self 
		changed: #contactSelectedIndex;
  		changed: #hasSelectedContact