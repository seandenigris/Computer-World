as yet unclassified
toggleAutoHide
	"From https://discussions.apple.com/message/21990325#message21990325"

	| command |
	command := 'osascript -e ''tell application "System Events" to set autohide of dock preferences to not (autohide of dock preferences)'''.
	self run: command