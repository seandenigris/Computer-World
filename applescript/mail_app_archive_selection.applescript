tell application "Mail"
	set targetMailbox to mailbox "Dynabook Archive"
	
	set msgs to selection

    repeat with msg in msgs
        set mailbox of msg to targetMailbox
    end repeat

end tell