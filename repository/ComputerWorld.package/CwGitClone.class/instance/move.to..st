as yet unclassified
move: sourceReference to: targetReference
	self 
		run: '{gitBinary} mv "{sourceReference}" "{targetReference}"' 
		with: { #sourceReference -> sourceReference. #targetReference -> targetReference }