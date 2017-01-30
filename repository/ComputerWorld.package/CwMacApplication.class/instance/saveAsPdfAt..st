actions
saveAsPdfAt: aFileReference
	"Saves the current document"

	self tellGUITo: 'click menu item "Print…" of menu 1 of menu bar item "File"  of menu bar 1
	click menu button "PDF"  of sheet 1 of window 1
	-- select menu item 2 of menu 1 of menu button "PDF"  of sheet 1 of window 1
	try
		tell menu item 2 of menu 1 of menu button "PDF"  of sheet 1 of window 1
			select
			set {xPosition, yPosition} to position
			set {xSize, ySize} to size
		end tell
		-- modify offsets if hot spot is not centered:
		click at {xPosition + (xSize div 2), yPosition + (ySize div 2)}
	end try
	
	delay 1
	
	set value of text field 1 of window "Save"  to "', aFileReference basename, '"
	
	-- Open dialog to set path
	key code 5 using {command down, shift down} -- g key'.
	Clipboard clipboardText: aFileReference parent fullName.
	self tellGUITo: 'key code 9 using {command down} -- v key
	click button "Go"  of sheet 1 of window "Save"
	click button "Save"  of window "Save"'.