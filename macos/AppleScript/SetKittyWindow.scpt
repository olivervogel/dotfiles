if application "kitty" is running then
	tell application "System Events"
		set position of first window of application process "kitty" to {0, 0}
		set size of first window of application process "kitty" to {3000, 3000}
	end tell
end if
