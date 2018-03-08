accessing
commit: messageString
	self 
		run: '{gitBinary} commit -m "{message}"' 
		with: { #message -> messageString }