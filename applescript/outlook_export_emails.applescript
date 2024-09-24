-- Adapted from https://www.mothsoftware.com/exporting-emails-from-outlook-with-applescript

use framework "Foundation"
use scripting additions

property maxLength : 250
property FileEnding : ".eml"

on run argv
	tell application "Microsoft Outlook"
		
		--check if there is an email selected
		set selectedMessages to selection
		if selectedMessages is missing value or class of selectedMessages is mail folder then
			display dialog "Please select an email first!"
			return
		end if
		
		repeat with theMessage in selectedMessages
			
			--get basic data
			set theSubject to subject of theMessage
			set theSource to source of theMessage
			set theDate to time received of theMessage
			if theDate is missing value then
				set theDate to time sent of theMessage
			end if
			
			--prepare data for writing
			set theSubject to my format_date(theDate) & " " & theSubject
			set theSubject to my replace_chars(theSubject, ":", "_")
			set theSubject to my replace_chars(theSubject, "/", "_")
			set theSubject to my get_string_with_maxlength(theSubject)
			
			--destination is first argument passed to the script		
			set the_folder to item 1 of argv
			set file_name to theSubject & FileEnding
			set this_file to my file_in_folder(file_name, the_folder) as string
			
			--write data to file
			my write_to_file(theSource, this_file, true)
		end repeat
		
	end tell
end run

on file_in_folder(file_name, the_folder)
	--Can't be inside a tell block
	return POSIX file (the_folder & "/" & file_name)
end file_in_folder


--format the date of the email: makes an sql date type out of the date 2022-08-10
on format_date(theDate)
	set theYear to year of theDate
	set theMonth to (month of theDate) as integer
	set theDay to day of theDate
	return (theYear & "-" & theMonth & "-" & theDay & "-" & time string of (theDate)) as string
end format_date

--write data to file
on write_to_file(this_data, target_file, append_data)
	tell application "Finder"
		try
			set the target_file to the target_file as string
			set the open_target_file to open for access file target_file with write permission
			if append_data is false then set eof of the open_target_file to 0
			write this_data to the open_target_file as Çclass utf8È starting at eof
			close access the open_target_file
			return true
		on error errMsg number errNr
			try
				display dialog errMsg & " Nr.: " & errNr
				close access file target_file
			end try
			return false
		end try
	end tell
end write_to_file

--replace characters in text
on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

on get_string_with_maxlength(theText)
	
	--get the full length of the string first
	set theLength to my get_precomposed_length(theText) as number
	if theLength ² maxLength then return theText
	
	--split the string into characters
	set TextAsArray to my split_string(theText, "")
	
	--for each character get the length
	set CharacterLengths to {}
	repeat with theChar in TextAsArray
		set CharLength to my get_precomposed_length(theChar)
		set end of CharacterLengths to CharLength
	end repeat
	
	--concatenate characters and count the length of the characters
	set currentLength to 0
	set Counter to 1
	set theText to ""
	repeat while currentLength < maxLength
		set currentLength to (item Counter of CharacterLengths) + currentLength
		set theText to theText & item Counter of TextAsArray
		set Counter to Counter + 1
	end repeat
	return theText
end get_string_with_maxlength

--convert the string to precomposed and get the length of the string
on get_precomposed_length(theText)
	set theApp to a reference to current application
	set theNSString to theApp's NSString's stringWithString:theText
	set theMutableNSString to theApp's NSMutableString's stringWithString:(theNSString's decomposedStringWithCanonicalMapping())
	return theMutableNSString's |length|() as text
end get_precomposed_length

on split_string(theString, theDelimiter)
	-- save delimiters to restore old settings
	set oldDelimiters to AppleScript's text item delimiters
	-- set delimiters to delimiter to be used
	set AppleScript's text item delimiters to theDelimiter
	set theArray to every text item of theString
	-- restore the old setting
	set AppleScript's text item delimiters to oldDelimiters
	return theArray
end split_string