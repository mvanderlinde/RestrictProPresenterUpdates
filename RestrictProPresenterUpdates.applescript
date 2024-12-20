on run {input, parameters}
	set dialogTitle to "Restrict ProPresenter Updates"
	
	set action to (display dialog "Would you like to lock or unlock updates?\n\nNote: You will be prompted for an admin password." with title dialogTitle buttons {"Lock", "Unlock", "Cancel"} default button 1)
	
	if the button returned of action is equal to "Lock" then
		set command to "uchg"
	else if the button returned of action is equal to "Unlock" then
		set command to "nouchg"
	else
		error number -128
	end if
	
	try
		do shell script "sudo mkdir -p ~/Library/Caches/com.renewedvision.propresenter/org.sparkle-project.Sparkle &&
sudo chflags " & command & " ~/Library/Caches/com.renewedvision.propresenter/org.sparkle-project.Sparkle" with administrator privileges
		
		if command is equal to "uchg" then
			set dialogMessage to "Updates are now LOCKED and will not work until unlocked."
		else if command is equal to "nouchg" then
			set dialogMessage to "Updates are now UNLOCKED and will once again work."
		end if
		
		display dialog dialogMessage with title dialogTitle buttons {"OK"} default button 1
	on error
		display dialog "Something went wrong, please try again." with title "Restrict ProPresenter Updates" buttons {"OK"} default button 1
	end try
	
	return
end run
