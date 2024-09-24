on run argv
	tell application "Microsoft Outlook"
		
		-- Adapted from https://www.mothsoftware.com/how-to-get-account-information-from-outlook-with-applescript
		set theAccountName to item 1 of argv
		set targetAccount to get first exchange account whose user name is theAccountName
		
		-- Adapted from https://stackoverflow.com/q/25850596
		set targetFolder to folder "Archive Dynabook" of folder "Archive" of targetAccount
		
		set msgs to get current messages
		
		repeat with aMessage in msgs
			move aMessage to targetFolder
		end repeat
	end tell
end run